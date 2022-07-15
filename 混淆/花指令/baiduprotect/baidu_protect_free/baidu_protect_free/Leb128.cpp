#include"Leb128.h"



/*
   * Reads an unsigned LEB128 value, updating the given pointer to point
   * just past the end of the read value. This function tolerates
   * non-zero high-order bits in the fifth encoded byte.
   */
   //读取一个LEB128编码的无符号数，参数指针也会移动
unsigned int readUnsignedLeb128(const unsigned char **pStream)
{
	const unsigned char *ptr = *pStream;
	int result = *(ptr++);

	if (result > 0x7f)
	{
		int cur = *(ptr++);
		result = (result & 0x7f) | ((cur & 0x7f) << 7);
		if (cur > 0x7f)
		{
			cur = *(ptr++);
			result |= (cur & 0x7f) << 14;
			if (cur > 0x7f)
			{
				cur = *(ptr++);
				result |= (cur & 0x7f) << 21;
				if (cur > 0x7f)
				{
					/*
					 * Note: We don't check to see if cur is out of
					 * range here, meaning we tolerate garbage in the
					 * high four-order bits.
					 */
					cur = *(ptr++);
					result |= cur << 28;
				}
			}
		}
	}

	*pStream = ptr;
	return result;
}

/*
 * Reads a signed LEB128 value, updating the given pointer to point
 * just past the end of the read value. This function tolerates
 * non-zero high-order bits in the fifth encoded byte.
 */
 //读取一个LEB128编码的有符号数，参数指针也会移动
int readSignedLeb128(const unsigned char **pStream)
{
	const unsigned char *ptr = *pStream;
	int result = *(ptr++);

	if (result <= 0x7f)
	{
		result = (result << 25) >> 25;
	}
	else
	{
		int cur = *(ptr++);
		result = (result & 0x7f) | ((cur & 0x7f) << 7);
		if (cur <= 0x7f)
		{
			result = (result << 18) >> 18;
		}
		else
		{
			cur = *(ptr++);
			result |= (cur & 0x7f) << 14;
			if (cur <= 0x7f)
			{
				result = (result << 11) >> 11;
			}
			else
			{
				cur = *(ptr++);
				result |= (cur & 0x7f) << 21;
				if (cur <= 0x7f)
				{
					result = (result << 4) >> 4;
				}
				else
				{
					/*
					 * Note: We don't check to see if cur is out of
					 * range here, meaning we tolerate garbage in the
					 * high four-order bits.
					 */
					cur = *(ptr++);
					result |= cur << 28;
				}
			}
		}
	}

	*pStream = ptr;
	return result;
}


/*
 * Writes a 32-bit value in unsigned ULEB128 format.
 *
 * Returns the updated pointer.
 */
unsigned char *writeUnsignedLeb128(unsigned char*ptr, u4 data)
{
	while (true)
	{
		u1 out = data & 0x7f;
		if (out != data)
		{
			*ptr++ = out | 0x80;
			data >>= 7;
		}
		else
		{
			*ptr++ = out;
			break;
		}
	}

	return ptr;
}

/*
 * Returns the number of bytes needed to encode "val" in ULEB128 form.
 */
int unsignedLeb128Size(u4 data)
{
	int count = 0;

	do
	{
		data >>= 7;
		count++;
	} while (data != 0);

	return count;
}