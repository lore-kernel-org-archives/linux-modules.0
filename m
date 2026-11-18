Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007991;
	b=I04P+VvQjDeSlo0g0DhO6daym96aGtnQsROgRW3uWGgahSTM3iAfM11XCTwkt+f+Fc6l
	 09dMN2oFukmtV//Kh4JejIqrtWl444B4VG5WeQfwqkK5Gg73XwGQ9e+MkY9adyJ5Cgmnp
	 Czx9jmTojWQi2qhncXmzloaM/UwaU499QICUx/wXEL4I1j7cNU/WeL3HnJFkhXCX+ZeLP
	 z8ViG7qTg9MRGvykB/0gnRstuiEVdZtX50Asw5qNrLYxO8CkYjK1OYDJ9FijSRJ0wpfrx
	 ae0C5TFg+8fEEfatdZC19kgdHQv0cgIf5e4dVhFn+1aPqHAwD8vv0TsFdR9GT4P1eHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=93Uj5YlJiJDUPqQt02zfaVf+8qWZByKLyR/rRwtPCWI=;
	b=psHkT6+2FeHfRlpLd8LLKjOx4zLOkaPDigtOubZ82Puc2PvjQ4C2KXc40iyDoHOAc5rD
	 tbRtIiZoQBRXoXBRMY97x2rH0PLixu6B9QsGAyD+pD3s4Dl7Ia39hxdVMh1Wc7dPDQ09N
	 aTAThJRJ/hZjlfsrcx/qG5PIp1ZlsWn11IkddhkzPv8ZdRNYks8BSMF4Q2gsdxGaa/Irl
	 zo34HdofCxVSTLxmslun672e9XABaJX6X/2mGdhRm/MeNKzmHylM/2afiIESSuyz7yg+k
	 ByOrPhEszv/6SemNQZSm7m19FkgdVlS26I3JEHmNiUyRMORT9e2gwwTZFNddU5D7ThQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Y434dVE3;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE2606A325
	for <linux-modules@vger.kernel.org>; Wed, 18 Nov 2026 13:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CE2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Y434dVE3
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb61185057so7992955e9.1
        for <linux-modules@vger.kernel.org>; Wed, 18 Nov 2026 05:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795007988; x=1795612788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93Uj5YlJiJDUPqQt02zfaVf+8qWZByKLyR/rRwtPCWI=;
        b=Y434dVE3SaNsU7j3zoVT/FqTeXOB/+iRps4Z3i9BHLEz16vp4YjcfNzKf32fOzWv6f
         eLeYkeG+4gEEPYjS6PldWx89jyh9HDErDo8HeM57clCniLe+MUlN5PYZUcmrAMa1v7Jc
         7Oy/U84NreNYGujiplHDk9Bhhah6+efymLH5FPBDDSbHDpa/Qky5dUma5aQVNdLmPbZs
         r1Ele7NPgsy+GCRTfiKLfXMMnzImTDu+3f+KqygFKUNnAmXddHBR1ABUOf2/yafZTvpm
         OuLWQSFfEst3Df1lwW9Mr7dKwtErIsHGLO6zoijeYaDK/eN++wMmx3Wbhb5MKaUEUlnf
         zxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007988; x=1795612788;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93Uj5YlJiJDUPqQt02zfaVf+8qWZByKLyR/rRwtPCWI=;
        b=Iyvd9zwqatu4q83f7+9b8drMSqkuhGaDopx4O2Gf2ROF/f9wJ7CHgZQ7PNjg32nFHZ
         qGpFV+qmUiy9nyzGzdW4bNvfJY1/jNaOJy59knFhUmVi14aYlXd1Jhcx8YJDmepLggMe
         V/oERJz6U3mPdJE6fsMCwrwRbWSUFaVQ0HpJm4dFgTEXsDC7r+Lw1v3sBChspi9H/ITv
         9XgskpP3F3SEWfRRc0hm5cjLN1KTGS2K1ah8Hog3AuliUvpKrK/krfTJUV+aRHO7wcUE
         c6699HIvpMFIxU2/VJScMArr4N5RSQGSJ2R3/AA4VdOxCJL5VvnmKCM8/zCu3gLJbCkj
         Vi+A==
X-Forwarded-Encrypted: i=1; AL+hErE2oAUJVRR3rq5M9fFNCLi3sWEcGrCFUqe7R6fG/HrPp3EQ7NbsX5i71cB6LRdWtWeczNUqgjorJufcYVqw@vger.kernel.org
X-Gm-Message-State: APuU4Z/rEUH5y7gJY2d+DuVq4mJ7tHDHOwxQRwJ7YHgdwdYmbGrJZuvr
	ClwqtVU0fjit4Zah0ZjsqJZ7FnfAQDRtce8qYPIrcWOi5vc1Dbt/dfPoD58Lr/ZtGAw=
X-Gm-Gg: AYBFou0qt4xGjtQ7mZHTc5I5YpJUxfO5ypS/9G2hHFKMu+9GQ99nBm8W3b9uXtmoc97
	1a8HDTZdm9n+YUCDdEULj1CYJrocVICbHyZaRqLRiomKFveFHFsCqgoL6f+IdjrYewWAu/yWZjd
	7NBArZ/Su0PbCOOW49wnL56lcRnZcgqhvQDJqQmBS19DgnMsUR7uOT4tyNywbqsbtPLcAa1Bssg
	WyQEFnIllGMyFnva2yxjLpBYAmV1cmVA74C9qfuxzdDQXDs8rWtZsaU2fylbWeRh2JxW8UUaR66
	CwSwyiXaAHHYp4jG0QjlYcnDgUKokV6W8FkuPzyEGghxfmsmW/bzgaFmU+PHliT/GGGk8J+f4Y5
	rKAj0Jqzdxn14vXeQ3/31mdih+4CVTQNDBtHqz61GLwr0iAAkhaRacmdyAVdC0PDzphdtXKtnDs
	5qY4CtaYG2Z7GNj7EeGxsKJpld3u3QPc68YIpKB3wzprTwfZ1adRrt4WzI4TRRYKyfZTBBd+tUY
	MgNaUsyQB+vCweuSlE390LwLScJtCrJafdKIDlP4OJgUaCbAQ1E7UKYrDqXuH3nHGlb+9KzPiw9
	vIETIqKq86jAzmP2xQK1+v/1r01tBCfgDQU+cLfjGc75y4QJ4YJ/nIvVcSPJRxbUdQ==
X-Received: by 2002:a05:600c:1f82:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb7da4f53fmr49945395e9.26.1795007988353;
        Wed, 18 Nov 2026 05:19:48 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f8154sm156191165e9.4.2026.11.18.05.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 05:19:48 -0800 (PST)
Message-ID: <59295e13-8324-4749-9e0d-e018b78ae2d7@suse.com>
Date: Wed, 18 Nov 2026 14:19:47 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Add LZ4 module compression
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org
References: <20261115120416.256087-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261115120416.256087-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 1:04 PM, Paul Menzel wrote:
> XZ modules are small but slow to decompress in the kernel. Therefore,
> support modules compressed in the LZ4 frame format (.ko.lz4), as written
> by lz4(1). Decode block by block into a scratch buffer and copy into the
> module pages. Linked blocks keep the last 64 KiB of output in front of
> the scratch buffer as the dictionary. Verify the header checksum, block
> checksums, content checksum and content size when the frame has them.
> Frames with a dictionary ID are rejected.
> 
> modules_install uses `lz4 -12 -B4 -BD`: 64 KiB linked blocks are as
> small as 4 MiB blocks (i915.ko: 3587140 vs 3585364 bytes) and keep the
> scratch buffer at 128 KiB.
> 
> Userspace needs kmod with LZ4 support for depmod and modprobe [1].
> 
> On a Dell XPS 13 9310 with an Intel Core i7-1165G7 (Tiger Lake) and an
> NVMe SSD, decompressing and checking the signatures of the 237 modules
> loaded during boot takes 624 ms of CPU time with XZ (i915: 91 ms) and
> 131 ms with LZ4 (i915: 12 ms), measured by calling finit_module() again
> for each loaded module. The LZ4 modules take 20.3 MB instead of 11.0 MB.
> Both kernels are v7.4-rc1 with the same patches, including pending
> lib/xz decoder speed-ups. Ten alternating boots of each kernel:
> 
>   | ms (median)                               |  XZ  | LZ4  | change |
>   +-------------------------------------------+------+------+--------+
>   | early-i915 (modprobe i915 + dependencies) |  295 |   90 |   -205 |
>   | first i915 message                        |  738 |  547 |   -192 |
>   | GDM autologin                             |  973 |  876 |    -96 |
>   | GRUB start to autologin                   | 1292 | 1197 |    -94 |
> 
> QEMU 11.1.2 (KVM, AMD EPYC 7763, 8 vCPUs, module.sig_enforce=1, 10
> rounds), loading the same 237 modules in dependency order:
> 
>   | median                   |   XZ    |   LZ4   | uncompressed |
>   +--------------------------+---------+---------+--------------+
>   | one at a time            | 2082 ms | 1499 ms |      1461 ms |
>   | 8 in parallel, like udev |  619 ms |  573 ms |       593 ms |
> 
> Link: https://github.com/kmod-project/kmod/pull/505 [1]
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Which Linux distributions are interested in LZ4 compression for modules
and plan to use this feature?

> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index cce098671be97..028b411015f21 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -287,6 +287,249 @@ static ssize_t module_zstd_decompress(struct load_info *info,
>  	kvfree(wksp);
>  	return retval;
>  }
> +#elif defined(CONFIG_MODULE_COMPRESS_LZ4)
> +#include <linux/bitfield.h>
> +#include <linux/lz4.h>
> +#include <linux/sizes.h>
> +#include <linux/unaligned.h>
> +#include <linux/xxhash.h>
> +#define MODULE_COMPRESSION	lz4
> +#define MODULE_DECOMPRESS_FN	module_lz4_decompress
> +
> +/*
> + * Decoder for the LZ4 frame format written by lz4(1), see
> + * https://github.com/lz4/lz4/blob/dev/doc/lz4_Frame_format.md
> + *
> + * Each block is decoded into a scratch buffer and copied into the module
> + * pages. A linked block may reference up to 64 KiB of the output before
> + * it, so that much output is kept in front of the scratch buffer.
> + */
> +#define LZ4F_MAGIC		0x184d2204
> +
> +/* Frame descriptor, FLG byte */
> +#define LZ4F_FLG_VERSION	GENMASK(7, 6)
> +#define LZ4F_FLG_BLOCK_INDEP	BIT(5)
> +#define LZ4F_FLG_BLOCK_CSUM	BIT(4)
> +#define LZ4F_FLG_CONTENT_SIZE	BIT(3)
> +#define LZ4F_FLG_CONTENT_CSUM	BIT(2)
> +#define LZ4F_FLG_RESERVED	BIT(1)
> +#define LZ4F_FLG_DICT_ID	BIT(0)
> +
> +/* Frame descriptor, BD byte */
> +#define LZ4F_BD_BLOCK_MAXSIZE	GENMASK(6, 4)
> +#define LZ4F_BD_RESERVED	(BIT(7) | GENMASK(3, 0))
> +
> +/* Block size field: the top bit marks a block stored uncompressed */
> +#define LZ4F_BLOCK_UNCOMPRESSED	BIT(31)
> +
> +#define LZ4F_WINDOW_SIZE	SZ_64K
> +
> +/* Block maximum sizes for the BD byte's Block MaxSize values 4 to 7 */
> +static const u32 lz4f_block_max[] = { SZ_64K, SZ_256K, SZ_1M, SZ_4M };
> +
> +static int module_lz4_copy_out(struct load_info *info, const u8 *src,
> +			       size_t len, size_t *total)
> +{
> +	while (len) {
> +		size_t offset = *total % PAGE_SIZE;
> +		size_t chunk = min_t(size_t, len, PAGE_SIZE - offset);
> +		struct page *page;
> +
> +		if (offset)
> +			page = info->pages[info->used_pages - 1];
> +		else
> +			page = module_get_next_page(info);
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +
> +		memcpy_to_page(page, offset, src, chunk);
> +		src += chunk;
> +		len -= chunk;
> +		*total += chunk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int module_lz4_verify_content(struct load_info *info, size_t total,
> +				     u32 expected)
> +{
> +	void *data;
> +	u32 csum;
> +
> +	data = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL_RO);
> +	if (!data)
> +		return -ENOMEM;
> +	csum = xxh32(data, total, 0);
> +	vunmap(data);
> +
> +	if (csum != expected) {
> +		pr_err("LZ4-compressed data is corrupt (content checksum)\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t module_lz4_decompress(struct load_info *info,
> +				     const void *buf, size_t size)
> +{
> +	const u8 *in = buf, *end = in + size, *desc;
> +	size_t block_max, total = 0, dict_len = 0;
> +	u64 content_size = 0;
> +	u8 *scratch, *out;
> +	bool linked;
> +	u8 flg, bd;
> +	ssize_t retval;
> +
> +	if (size < 7 || get_unaligned_le32(in) != LZ4F_MAGIC) {
> +		pr_err("not an lz4 compressed module\n");
> +		return -EINVAL;
> +	}
> +
> +	desc = in + 4;
> +	flg = desc[0];
> +	bd = desc[1];
> +	in = desc + 2;
> +	if (FIELD_GET(LZ4F_FLG_VERSION, flg) != 1 ||
> +	    (flg & LZ4F_FLG_RESERVED) || (bd & LZ4F_BD_RESERVED) ||
> +	    FIELD_GET(LZ4F_BD_BLOCK_MAXSIZE, bd) < 4) {
> +		pr_err("LZ4-compressed data has an unsupported frame descriptor\n");
> +		return -EINVAL;
> +	}
> +	if (flg & LZ4F_FLG_DICT_ID) {
> +		pr_err("LZ4-compressed data needs a dictionary\n");
> +		return -EINVAL;
> +	}
> +	if (flg & LZ4F_FLG_CONTENT_SIZE) {
> +		if (end - in < 8)
> +			goto truncated_header;
> +		content_size = get_unaligned_le64(in);
> +		in += 8;
> +	}
> +	if (end - in < 1)
> +		goto truncated_header;
> +	if (*in != ((xxh32(desc, in - desc, 0) >> 8) & 0xff)) {
> +		pr_err("LZ4-compressed data has a corrupt frame descriptor\n");
> +		return -EINVAL;
> +	}
> +	in++;
> +
> +	block_max = lz4f_block_max[FIELD_GET(LZ4F_BD_BLOCK_MAXSIZE, bd) - 4];
> +	linked = !(flg & LZ4F_FLG_BLOCK_INDEP);
> +
> +	scratch = kvmalloc((linked ? LZ4F_WINDOW_SIZE : 0) + block_max,
> +			   GFP_KERNEL);
> +	if (!scratch)
> +		return -ENOMEM;
> +	out = scratch + (linked ? LZ4F_WINDOW_SIZE : 0);
> +
> +	for (;;) {
> +		u32 block_size;
> +		size_t len;
> +		int ret;
> +
> +		if (end - in < 4)
> +			goto truncated;
> +		block_size = get_unaligned_le32(in);
> +		in += 4;
> +		if (!block_size)
> +			break;
> +
> +		len = block_size & ~LZ4F_BLOCK_UNCOMPRESSED;
> +		if (len > block_max) {
> +			pr_err("LZ4-compressed data has an oversized block\n");
> +			retval = -EINVAL;
> +			goto out;
> +		}
> +		if ((size_t)(end - in) < len +
> +		    (flg & LZ4F_FLG_BLOCK_CSUM ? 4 : 0))
> +			goto truncated;
> +
> +		if ((flg & LZ4F_FLG_BLOCK_CSUM) &&
> +		    xxh32(in, len, 0) != get_unaligned_le32(in + len)) {
> +			pr_err("LZ4-compressed data is corrupt (block checksum)\n");
> +			retval = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (block_size & LZ4F_BLOCK_UNCOMPRESSED) {
> +			memcpy(out, in, len);
> +			ret = len;
> +		} else if (linked) {
> +			ret = LZ4_decompress_safe_usingDict(in, out, len,
> +							    block_max,
> +							    out - dict_len,
> +							    dict_len);
> +		} else {
> +			ret = LZ4_decompress_safe(in, out, len, block_max);
> +		}
> +		if (ret < 0) {
> +			pr_err("LZ4-decompression failed\n");
> +			retval = -EINVAL;
> +			goto out;
> +		}
> +
> +		retval = module_lz4_copy_out(info, out, ret, &total);
> +		if (retval)
> +			goto out;
> +
> +		if (linked) {
> +			/* Keep the last 64 KiB as the next block's dictionary. */
> +			size_t keep = min_t(size_t, dict_len + ret,
> +					    LZ4F_WINDOW_SIZE);
> +
> +			memmove(out - keep, out + ret - keep, keep);
> +			dict_len = keep;
> +		}
> +
> +		in += len;
> +		if (flg & LZ4F_FLG_BLOCK_CSUM)
> +			in += 4;
> +	}
> +
> +	if (!total) {
> +		pr_err("LZ4-compressed module is empty\n");
> +		retval = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (flg & LZ4F_FLG_CONTENT_CSUM) {
> +		if (end - in < 4)
> +			goto truncated;
> +		retval = module_lz4_verify_content(info, total,
> +						   get_unaligned_le32(in));
> +		if (retval)
> +			goto out;
> +		in += 4;
> +	}
> +
> +	if (in != end) {
> +		pr_err("LZ4-compressed module has trailing data\n");
> +		retval = -EINVAL;
> +		goto out;
> +	}
> +
> +	if ((flg & LZ4F_FLG_CONTENT_SIZE) && content_size != total) {
> +		pr_err("LZ4-compressed data has a wrong content size\n");
> +		retval = -EINVAL;
> +		goto out;
> +	}
> +
> +	retval = total;
> +	goto out;
> +
> +truncated:
> +	pr_err("LZ4-compressed data is truncated\n");
> +	retval = -EINVAL;
> +out:
> +	kvfree(scratch);
> +	return retval;
> +
> +truncated_header:
> +	pr_err("LZ4-compressed data is truncated\n");
> +	return -EINVAL;
> +}
>  #else
>  #error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
>  #endif

I think the module loader shouldn't implement an LZ4 frame decoder
itself. I'd expect that functionality to be provided by lib/lz4/ and the
module loader should only be a user of it.

The LZ4 block format implementation in lib/lz4/ is derived from the
original LZ4 code. Have you considered similarly adapting the original
LZ4 frame decoder instead of writing a new one?

-- 
Thanks,
Petr
