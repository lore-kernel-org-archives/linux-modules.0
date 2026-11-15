Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794764144;
	b=l9nTKT/dY8MicXcuQvmau66p2LgfdXg5EXzHp7c7YNYi104bnGMNZ5FBjU2qMiYtQctD
	 Tyyjo5nzdoZml/kQvsJieD6wobgtYTeUrxsqSfnp70AX6vAsdMiWpkWtlsFaqXf3k3jZq
	 R4CPP7lFntU/PWaN4NDwJN7oXdepWQ5KyEv8vDU33MVjTlsMBWNTmLl+VBS0cf1PSKYXs
	 PehZD2zUFhDMqw+9UuzChZ7YxQld041veb7XW/9Z8FnzxdzL3wqB9N8QTAvCaLr7TebyP
	 NBxs0FerouYEUcNTY5y6VOOwhEPYWkJwl6OwJDoM39fqD5lPPFhCRWjrl8NRukDWuig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794764144;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lspihV9sabnt77BYoIwohTObWXfV/yR38PdA4p4y2Rc=;
	b=X0Z4i1NHLZgZESHmYtu+aUVaph4WMWDFbfK4+wwHECXsHk3DT4Lcs7nBuTk+97laoEJF
	 8LiOU4aal/WFMhZKaLAblgiUVNXhPcr6e0mmZgAvtFXfhBMrDWqLmrlz+xU5PSf7Q3LtV
	 peN9YqNkhJACInOVikwwFsbEXSIrqlUGYflVFuOqAEBbNIgOsHkJ6tllBEnPYb3MEIwOk
	 8sBOj+cU028yrTlH9dIMa+pmXK97vUo4MyQxekchTN9FrMpsptFPaxZAr7S2pHqly8P2d
	 fe0v/vEg2w/iPImEgy5UVLQQoWrNfJw1wN8Ltugcw0wkDeG+RHlFRRYHXlv9mWshqdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LtsVlaot;
	arc=none smtp.remote-ip=95.215.58.228
Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E0606A31A
	for <linux-modules@vger.kernel.org>; Sun, 15 Nov 2026 17:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84E0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LtsVlaot
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Dg7ozzUo4JrR8tJTNFoS81gXHtiH5tSaotXpu14sOA4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794764138; v=1; x=1795368938;
 b=LtsVlaotesm6ZZHyvPk+xYoGkY5eTjY4a+3gpIJ4lgxMqzZBW0tV99unV1BIXdXQ4l40w3m2
 pIGurSN4HxLkVVzfVbH+giR4Exaphrrf8Z6zfBPLPKMyQyYeFibhXNowWQTGM/war1ZOd8HdwzF
 EHLRI2UpK7mIMzfZlJLcplC8=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7d4708a459d7340b;
	Sun, 15 Nov 2026 17:35:38 +0000
X-Mizu-Trace-ID: 7d4708a459d7340b
X-Migadu-Flow: FLOW_OUT
Date: Sun, 15 Nov 2026 17:35:32 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: pmenzel@molgen.mpg.de
CC: atomlin@atomlin.com, da.gomez@kernel.org, dsterba@suse.com,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, nathan@kernel.org,
 nsc@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 terrelln@fb.com
Subject: Re: [PATCH v2] module: Add LZ4 module compression
In-Reply-To: <20261115120416.256087-1-pmenzel@molgen.mpg.de>
Message-ID: <F2B70664-1E9A-427C-9132-A0F5F586F731@linux.dev>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 15 November 2026 12:04:13 GMT, Paul Menzel <pmenzel@molgen.mpg.de>
wrote:
>XZ modules are small but slow to decompress in the kernel. Therefore,
>support modules compressed in the LZ4 frame format (.ko.lz4), as written
>by lz4(1). Decode block by block into a scratch buffer and copy into the
>module pages. Linked blocks keep the last 64 KiB of output in front of
>the scratch buffer as the dictionary. Verify the header checksum, block
>checksums, content checksum and content size when the frame has them.
>Frames with a dictionary ID are rejected.

.ko.lz4? when would this be used..?

>
>modules_install uses `lz4 -12 -B4 -BD`: 64 KiB linked blocks are as
>small as 4 MiB blocks (i915.ko: 3587140 vs 3585364 bytes) and keep the
>scratch buffer at 128 KiB.
>
>Userspace needs kmod with LZ4 support for depmod and modprobe [1].
>
>On a Dell XPS 13 9310 with an Intel Core i7-1165G7 (Tiger Lake) and an
>NVMe SSD, decompressing and checking the signatures of the 237 modules
>loaded during boot takes 624 ms of CPU time with XZ (i915: 91 ms) and
>131 ms with LZ4 (i915: 12 ms), measured by calling finit_module() again
>for each loaded module. The LZ4 modules take 20.3 MB instead of 11.0 MB.
>Both kernels are v7.4-rc1 with the same patches, including pending
>lib/xz decoder speed-ups. Ten alternating boots of each kernel:
>
>  | ms (median)                               |  XZ  | LZ4  | change |
>  +-------------------------------------------+------+------+--------+
>  | early-i915 (modprobe i915 + dependencies) |  295 |   90 |   -205 |
>  | first i915 message                        |  738 |  547 |   -192 |
>  | GDM autologin                             |  973 |  876 |    -96 |
>  | GRUB start to autologin                   | 1292 | 1197 |    -94 |
>
>QEMU 11.1.2 (KVM, AMD EPYC 7763, 8 vCPUs, module.sig_enforce=1, 10
>rounds), loading the same 237 modules in dependency order:
>
>  | median                   |   XZ    |   LZ4   | uncompressed |
>  +--------------------------+---------+---------+--------------+
>  | one at a time            | 2082 ms | 1499 ms |      1461 ms |
>  | 8 in parallel, like udev |  619 ms |  573 ms |       593 ms |

This table doesn't look very nicely formatted for me.

>
>Link: https://github.com/kmod-project/kmod/pull/505 [1]
>Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>---
>
>Notes:
>    Changes in v2:
>    - Declare retval as ssize_t, so output of 2 GiB or more is not
>      truncated (Sashiko). The zstd decoder has the same bug, fixed by
>      the separate patch "module/decompress: Use ssize_t for the zstd
>      decompressed size".
>    - Reject empty frames with -EINVAL; v1 failed vmap() of 0 pages with
>      -ENOMEM (Sashiko).
>    - Describe the decoder and link the frame format specification, group
>      the definitions by FLG byte, BD byte and block size field, compare the
>      version with FIELD_GET(), rename LZ4F_DICT_SIZE to LZ4F_WINDOW_SIZE,
>      look up the block maximum size in a table, shorten the dictionary
>      comment (Bradley Morgan).
>    
>    v1: https://lore.kernel.org/all/20261113144233.193782-1-pmenzel@molgen.mpg.de/
>    
>    Claude Opus 5.5 (Claude Code) wrote the decoder, the v2
>    changes and this message. Tests: W=1 compile (GCC 16.2, Debian config
>    for x86_64, tinyconfig for i386); QEMU with module.sig_enforce=1: 11 LZ4
>    frame variants (64 KiB-4 MiB, linked/independent, block/content
>    checksums, content size, stored blocks) load, 9 corrupt, truncated or
>    empty files are rejected with EINVAL or EKEYREJECTED (v1: ENOMEM for the
>    empty ones); the 237-module boot set loads in QEMU. v1 also loaded on a
>    Dell XPS 13 9310 (20 boots); v2 was not booted on hardware.

Could you do a favour and test patches you submit, just in case of the
edgecases :)

>
> kernel/module/Kconfig      |  13 +-
> kernel/module/decompress.c | 243 +++++++++++++++++++++++++++++++++++++
> scripts/Makefile.modinst   |   6 +
> 3 files changed, 261 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
>index 43b1bb01fd273..36f12612c74dd 100644
>--- a/kernel/module/Kconfig
>+++ b/kernel/module/Kconfig
>@@ -344,7 +344,7 @@ config MODULE_COMPRESS
> 	  This is fully compatible with signed modules.
> 
> 	  The tool used to work with modules needs to support the selected
>-	  compression type. kmod MAY support gzip, xz and zstd. Other tools
>+	  compression type. kmod MAY support gzip, xz, zstd and lz4. Other tools
> 	  might have a limited selection of the supported types.
> 
> 	  Note that for modules inside an initrd or initramfs, it's more
>@@ -377,6 +377,15 @@ config MODULE_COMPRESS_ZSTD
> 	  Support modules compressed with ZSTD. The installed modules are
> 	  suffixed with .ko.zst.
> 
>+config MODULE_COMPRESS_LZ4
>+	bool "LZ4"
>+	help
>+	  Support modules compressed with LZ4. The installed modules are
>+	  suffixed with .ko.lz4.
>+
>+	  LZ4 modules are larger than XZ or ZSTD ones but decompress
>+	  several times faster.
>+
> endchoice
> 
> config MODULE_COMPRESS_ALL
>@@ -394,6 +403,8 @@ config MODULE_DECOMPRESS
> 	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
> 	select XZ_DEC if MODULE_COMPRESS_XZ
> 	select ZSTD_DECOMPRESS if MODULE_COMPRESS_ZSTD
>+	select LZ4_DECOMPRESS if MODULE_COMPRESS_LZ4
>+	select XXHASH if MODULE_COMPRESS_LZ4
> 	help
> 	  Support for decompressing kernel modules by the kernel itself
> 	  instead of relying on userspace to perform this task. Useful when
>diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
>index cce098671be97..028b411015f21 100644
>--- a/kernel/module/decompress.c
>+++ b/kernel/module/decompress.c
>@@ -287,6 +287,249 @@ static ssize_t module_zstd_decompress(struct load_info *info,
> 	kvfree(wksp);
> 	return retval;
> }
>+#elif defined(CONFIG_MODULE_COMPRESS_LZ4)
>+#include <linux/bitfield.h>
>+#include <linux/lz4.h>
>+#include <linux/sizes.h>
>+#include <linux/unaligned.h>
>+#include <linux/xxhash.h>
>+#define MODULE_COMPRESSION	lz4
>+#define MODULE_DECOMPRESS_FN	module_lz4_decompress
>+

Oh these includes mid file are a MESS! No, please no. Good to if defined,
but I'm sure the maintainer wouldn't mind if you ifdefed those includes on
the TOP of the file. Like any other normal kernel file.

>+/*
>+ * Decoder for the LZ4 frame format written by lz4(1), see
>+ * https://github.com/lz4/lz4/blob/dev/doc/lz4_Frame_format.md
>+ *
>+ * Each block is decoded into a scratch buffer and copied into the module
>+ * pages. A linked block may reference up to 64 KiB of the output before
>+ * it, so that much output is kept in front of the scratch buffer.
>+ */

Well, I suggested something better,

/* Decoder for the lz4 frame format,
 * written by lz4 [1]
 * This code adds support for lz4
 * modules inside the kernel, so 
 * that lz4 modules can be used.
 * 
 * [1] - (your link, lz4 frame format src??)
 */

What about this?

I say bikeshed, but let's not make it TOO sloppy, you reckon?

>+#define LZ4F_MAGIC		0x184d2204
>+
>+/* Frame descriptor, FLG byte */
>+#define LZ4F_FLG_VERSION	GENMASK(7, 6)
>+#define LZ4F_FLG_BLOCK_INDEP	BIT(5)
>+#define LZ4F_FLG_BLOCK_CSUM	BIT(4)
>+#define LZ4F_FLG_CONTENT_SIZE	BIT(3)
>+#define LZ4F_FLG_CONTENT_CSUM	BIT(2)
>+#define LZ4F_FLG_RESERVED	BIT(1)
>+#define LZ4F_FLG_DICT_ID	BIT(0)
>+
>+/* Frame descriptor, BD byte */
>+#define LZ4F_BD_BLOCK_MAXSIZE	GENMASK(6, 4)
>+#define LZ4F_BD_RESERVED	(BIT(7) | GENMASK(3, 0))
>+
>+/* Block size field: the top bit marks a block stored uncompressed */
>+#define LZ4F_BLOCK_UNCOMPRESSED	BIT(31)
>+
>+#define LZ4F_WINDOW_SIZE	SZ_64K
>+
>+/* Block maximum sizes for the BD byte's Block MaxSize values 4 to 7 */
>+static const u32 lz4f_block_max[] = { SZ_64K, SZ_256K, SZ_1M, SZ_4M };
>+
>+static int module_lz4_copy_out(struct load_info *info, const u8 *src,
>+			       size_t len, size_t *total)
>+{
>+	while (len) {
>+		size_t offset = *total % PAGE_SIZE;
>+		size_t chunk = min_t(size_t, len, PAGE_SIZE - offset);
>+		struct page *page;
>+
>+		if (offset)
>+			page = info->pages[info->used_pages - 1];
>+		else
>+			page = module_get_next_page(info);
>+		if (IS_ERR(page))
>+			return PTR_ERR(page);
>+
>+		memcpy_to_page(page, offset, src, chunk);
>+		src += chunk;
>+		len -= chunk;
>+		*total += chunk;
>+	}
>+
>+	return 0;
>+}
>+
>+static int module_lz4_verify_content(struct load_info *info, size_t total,
>+				     u32 expected)
>+{
>+	void *data;
>+	u32 csum;
>+
>+	data = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL_RO);
>+	if (!data)
>+		return -ENOMEM;
>+	csum = xxh32(data, total, 0);
>+	vunmap(data);
>+
>+	if (csum != expected) {
>+		pr_err("LZ4-compressed data is corrupt (content checksum)\n");
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static ssize_t module_lz4_decompress(struct load_info *info,
>+				     const void *buf, size_t size)
>+{
>+	const u8 *in = buf, *end = in + size, *desc;
>+	size_t block_max, total = 0, dict_len = 0;
>+	u64 content_size = 0;
>+	u8 *scratch, *out;
>+	bool linked;
>+	u8 flg, bd;
>+	ssize_t retval;
>+
>+	if (size < 7 || get_unaligned_le32(in) != LZ4F_MAGIC) {
>+		pr_err("not an lz4 compressed module\n");
>+		return -EINVAL;
>+	}
>+
>+	desc = in + 4;
>+	flg = desc[0];
>+	bd = desc[1];
>+	in = desc + 2;
>+	if (FIELD_GET(LZ4F_FLG_VERSION, flg) != 1 ||
>+	    (flg & LZ4F_FLG_RESERVED) || (bd & LZ4F_BD_RESERVED) ||
>+	    FIELD_GET(LZ4F_BD_BLOCK_MAXSIZE, bd) < 4) {
>+		pr_err("LZ4-compressed data has an unsupported frame descriptor\n");

When would this be reached?

>+		return -EINVAL;
>+	}
>+	if (flg & LZ4F_FLG_DICT_ID) {
>+		pr_err("LZ4-compressed data needs a dictionary\n");
>+		return -EINVAL;
>+	}
>+	if (flg & LZ4F_FLG_CONTENT_SIZE) {
>+		if (end - in < 8)
>+			goto truncated_header;
>+		content_size = get_unaligned_le64(in);
>+		in += 8;
>+	}
>+	if (end - in < 1)
>+		goto truncated_header;
>+	if (*in != ((xxh32(desc, in - desc, 0) >> 8) & 0xff)) {
>+		pr_err("LZ4-compressed data has a corrupt frame descriptor\n");

Is there a mechanism in the future in order to understand the garbled crap
and fix it to make it manageable? (This can be future patch)

>+		return -EINVAL;
>+	}
>+	in++;
>+
>+	block_max = lz4f_block_max[FIELD_GET(LZ4F_BD_BLOCK_MAXSIZE, bd) - 4];
>+	linked = !(flg & LZ4F_FLG_BLOCK_INDEP);
>+
>+	scratch = kvmalloc((linked ? LZ4F_WINDOW_SIZE : 0) + block_max,
>+			   GFP_KERNEL);
>+	if (!scratch)
>+		return -ENOMEM;
>+	out = scratch + (linked ? LZ4F_WINDOW_SIZE : 0);
>+
>+	for (;;) {
>+		u32 block_size;
>+		size_t len;
>+		int ret;
>+
>+		if (end - in < 4)
>+			goto truncated;
>+		block_size = get_unaligned_le32(in);
>+		in += 4;
>+		if (!block_size)
>+			break;
>+
>+		len = block_size & ~LZ4F_BLOCK_UNCOMPRESSED;
>+		if (len > block_max) {
>+			pr_err("LZ4-compressed data has an oversized block\n");
>+			retval = -EINVAL;
>+			goto out;
>+		}
>+		if ((size_t)(end - in) < len +
>+		    (flg & LZ4F_FLG_BLOCK_CSUM ? 4 : 0))
>+			goto truncated;
>+
>+		if ((flg & LZ4F_FLG_BLOCK_CSUM) &&
>+		    xxh32(in, len, 0) != get_unaligned_le32(in + len)) {
>+			pr_err("LZ4-compressed data is corrupt (block checksum)\n");
>+			retval = -EINVAL;
>+			goto out;
>+		}
>+
>+		if (block_size & LZ4F_BLOCK_UNCOMPRESSED) {
>+			memcpy(out, in, len);
>+			ret = len;
>+		} else if (linked) {
>+			ret = LZ4_decompress_safe_usingDict(in, out, len,
>+							    block_max,
>+							    out - dict_len,
>+							    dict_len);
>+		} else {
>+			ret = LZ4_decompress_safe(in, out, len, block_max);
>+		}
>+		if (ret < 0) {
>+			pr_err("LZ4-decompression failed\n");
>+			retval = -EINVAL;
>+			goto out;
>+		}
>+
>+		retval = module_lz4_copy_out(info, out, ret, &total);
>+		if (retval)
>+			goto out;
>+
>+		if (linked) {
>+			/* Keep the last 64 KiB as the next block's dictionary. */
>+			size_t keep = min_t(size_t, dict_len + ret,
>+					    LZ4F_WINDOW_SIZE);
>+
>+			memmove(out - keep, out + ret - keep, keep);
>+			dict_len = keep;
>+		}
>+
>+		in += len;
>+		if (flg & LZ4F_FLG_BLOCK_CSUM)
>+			in += 4;
>+	}
>+
>+	if (!total) {
>+		pr_err("LZ4-compressed module is empty\n");
>+		retval = -EINVAL;
>+		goto out;
>+	}
>+
>+	if (flg & LZ4F_FLG_CONTENT_CSUM) {
>+		if (end - in < 4)
>+			goto truncated;
>+		retval = module_lz4_verify_content(info, total,
>+						   get_unaligned_le32(in));
>+		if (retval)
>+			goto out;
>+		in += 4;
>+	}
>+
>+	if (in != end) {
>+		pr_err("LZ4-compressed module has trailing data\n");
>+		retval = -EINVAL;
>+		goto out;
>+	}
>+
>+	if ((flg & LZ4F_FLG_CONTENT_SIZE) && content_size != total) {
>+		pr_err("LZ4-compressed data has a wrong content size\n");
>+		retval = -EINVAL;
>+		goto out;
>+	}
>+
>+	retval = total;
>+	goto out;
>+
>+truncated:
>+	pr_err("LZ4-compressed data is truncated\n");
>+	retval = -EINVAL;
>+out:
>+	kvfree(scratch);
>+	return retval;
>+
>+truncated_header:
>+	pr_err("LZ4-compressed data is truncated\n");
>+	return -EINVAL;
>+}
> #else
> #error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
> #endif

My concern here is that some of these gnarly functions are uncommented, so
when a noob reads this code, "Oh no! What does this do! Oops... I broke my
module"


Maybe comment for functions that are gnarly and you think a reader would
need to understand to be able to operate/contribute.

>diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
>index 9ba45e5b32b18..aebc5e89d0e75 100644
>--- a/scripts/Makefile.modinst
>+++ b/scripts/Makefile.modinst
>@@ -57,6 +57,7 @@ ifdef CONFIG_MODULE_COMPRESS_ALL
> suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
> suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
> suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
>+suffix-$(CONFIG_MODULE_COMPRESS_LZ4)	:= .lz4
> endif
> 
> modules := $(patsubst %.o, $(dst)/%.ko$(suffix-y), $(modules))
>@@ -151,6 +152,8 @@ quiet_cmd_xz = XZ      $@
>       cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<
> quiet_cmd_zstd = ZSTD    $@
>       cmd_zstd = $(ZSTD) --rm -f -q $<
>+quiet_cmd_lz4 = LZ4     $@
>+      cmd_lz4 = $(LZ4) -12 -B4 -BD --rm -f -q $< $@
> 
> $(dst)/%.ko.gz: $(dst)/%.ko FORCE
> 	$(call cmd,gzip)
>@@ -161,6 +164,9 @@ $(dst)/%.ko.xz: $(dst)/%.ko FORCE
> $(dst)/%.ko.zst: $(dst)/%.ko FORCE
> 	$(call cmd,zstd)
> 
>+$(dst)/%.ko.lz4: $(dst)/%.ko FORCE
>+	$(call cmd,lz4)
>+
> PHONY += FORCE
> FORCE:
> 
>

--- Thanks!
