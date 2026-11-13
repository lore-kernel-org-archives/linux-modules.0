Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608086;
	b=hmDppb2c6MSrJQ1g+6mLO7ph0EK7IKDRuNKW4/rFLr1WR8EROSIjWM2OQinn9qO+zUUf
	 dL15/wXbEhpacFEd4NBn4uuzU76IKt1UnDThd5IPeaEkf5vRd39T5z6WDBdJ5U1DrWxLO
	 2MKWY1tg9C/Lt4mb5Hk9T+PQdGuCMFYl1aQuXVbDwsBj1SYVpZb+wRq8Wc2+TZOXkGdyS
	 iEE5m1Oad/nCYImZX8xgh/X4WsIET/4NHHT+Y/YM7Vl+5+oMWPvSMJhW17cioOoytbK4x
	 7YBfNy2P5MsvLGzIrKpLgbx+FBSkIKaF3A2VCGtHr29qFWoU09LPYvB/DyayDlQQFlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608086;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R9rduGAl1SHAakLebetDlXuPxuUEhf5VdhoiXEwGJSs=;
	b=tNB7PCyjGipYcOf1fK68CwsDOYurUG9HkdCsCcu8ZoJCnh8HfenlkefnFsBhnR5L2MJR
	 jpQk8Idfd4B9gWpXWzo2v5vkv7RVujYCVcUrRvopaE9EUXC7mHP3FBlnt/CYRBobZHrNj
	 2KmbkWhg4+lKbPjGBgUfyK4HYwT6qCUlRwpio0zqxn9WVHNhBJdsaj6vPGDuEKCmW/U6/
	 EIb3V2tnK+TxlM1cC58X3bHZNjUupjia/55DHHC0IFDbwmjdetk2M2954rHboYgokq7XX
	 LpTX7qyrP9DkLo5D5axM5yXw9tbLaqZMtVLvMOZnzpkOjH9aFyd/p8aRqivOCy+2Tag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X7DQWJ7C;
	arc=none smtp.remote-ip=91.218.175.29
Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61C60A3831
	for <linux-modules@vger.kernel.org>; Fri, 13 Nov 2026 22:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC61C60A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X7DQWJ7C
X-Envelope-To: linux-modules@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B16odCs177cdXLEvKntuWHjttnpyOtVHrFIqeH/UPaQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794608083; v=1; x=1795212883;
 b=X7DQWJ7Colzn1U8y/9DcSRlM5eTDSn/YSFLFgihWL4YcdLpu2oDm0gRwzC862anvzLOmtRiW
 K2SJYkKLAZyauLnrtgmVnUylu2XDwp+xpqHrcrj01h57SWhtrG4FqqdiYMI8HWfv20UzHNc0jWm
 cufP0uEKFF68DDOGSA9e9wbE=
X-Envelope-To: linux-modules@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0adfe5a205e05619;
	Fri, 13 Nov 2026 22:14:42 +0000
X-Mizu-Trace-ID: 0adfe5a205e05619
X-Migadu-Flow: FLOW_OUT
Date: Fri, 13 Nov 2026 22:14:43 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: pmenzel@molgen.mpg.de
CC: atomlin@atomlin.com, da.gomez@kernel.org, dsterba@suse.com,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, nathan@kernel.org,
 nsc@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
 terrelln@fb.com
Subject: Re: [PATCH] module: Add LZ4 module compression
In-Reply-To: <20261113144233.193782-1-pmenzel@molgen.mpg.de>
Message-ID: <C55315CE-D1F3-487A-B9D6-A0BA457374E5@linux.dev>
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

On 13 November 2026 14:42:29 GMT, Paul Menzel <pmenzel@molgen.mpg.de>
wrote:
>XZ modules are small but slow to decompress in the kernel. Therefore,
>support modules compressed in the LZ4 frame format (.ko.lz4), as written
>by lz4(1). Decode block by block into a scratch buffer and copy into the
>module pages. Linked blocks keep the last 64 KiB of output in front of
>the scratch buffer as the dictionary. Verify the header checksum, block
>checksums, content checksum and content size when the frame has them.
>Frames with a dictionary ID are rejected.
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
>
>Link: https://github.com/kmod-project/kmod/pull/505 [1]
>Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>---
>
>Notes:
>    Assisted-by: Claude Opus 5.5 (Claude Code) wrote the decoder and this message. Tests: W=1 compile (GCC 16.2, Debian config); QEMU with module.sig_enforce=1: 11 LZ4 frame variants (64 KiB-4 MiB, linked/independent, block/content checksums, content size, stored blocks) load, 7 corrupt or truncated files are rejected; 237-module boot set loads in QEMU and on a Dell XPS 13 9310 (20 boots).
>
> kernel/module/Kconfig      |  13 ++-
> kernel/module/decompress.c | 227 +++++++++++++++++++++++++++++++++++++
> scripts/Makefile.modinst   |   6 +
> 3 files changed, 245 insertions(+), 1 deletion(-)
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
>+	  compression type. kmod MAY support gzip, lz4, xz and zstd. Other tools
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
>index cce098671be97..5828b7ec9d7b6 100644
>--- a/kernel/module/decompress.c
>+++ b/kernel/module/decompress.c
>@@ -287,6 +287,233 @@ static ssize_t module_zstd_decompress(struct load_info *info,
> 	kvfree(wksp);
> 	return retval;
> }

↓ wont you comment and say what this is?

>+#elif defined(CONFIG_MODULE_COMPRESS_LZ4)
>+#include <linux/bitfield.h>
>+#include <linux/lz4.h>
>+#include <linux/sizes.h>
>+#include <linux/unaligned.h>
>+#include <linux/xxhash.h>
>+#define MODULE_COMPRESSION	lz4
>+#define MODULE_DECOMPRESS_FN	module_lz4_decompress
>+
>+/* LZ4 frame format, as written by lz4(1) */
>+#define LZ4F_MAGIC		0x184d2204
>+#define LZ4F_FLG_VERSION_MASK	GENMASK(7, 6)
>+#define LZ4F_FLG_VERSION	0x40
>+#define LZ4F_FLG_BLOCK_INDEP	BIT(5)
>+#define LZ4F_FLG_BLOCK_CSUM	BIT(4)
>+#define LZ4F_FLG_CONTENT_SIZE	BIT(3)
>+#define LZ4F_FLG_CONTENT_CSUM	BIT(2)
>+#define LZ4F_FLG_RESERVED	BIT(1)
>+#define LZ4F_FLG_DICT_ID	BIT(0)
>+#define LZ4F_BD_MAX_SIZE	GENMASK(6, 4)
>+#define LZ4F_BD_RESERVED	(BIT(7) | GENMASK(3, 0))
>+#define LZ4F_BLOCK_UNCOMPRESSED	BIT(31)

These define blocks look odd.

>+/* Linked blocks may reference up to 64 KiB of earlier output. */
>+#define LZ4F_DICT_SIZE		SZ_64K

I feel this could be better, not got my thinking glasses on, any ideas?

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
>+	int retval;
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
>+	if ((flg & LZ4F_FLG_VERSION_MASK) != LZ4F_FLG_VERSION ||
>+	    (flg & LZ4F_FLG_RESERVED) || (bd & LZ4F_BD_RESERVED) ||
>+	    FIELD_GET(LZ4F_BD_MAX_SIZE, bd) < 4) {
>+		pr_err("LZ4-compressed data has an unsupported frame descriptor\n");
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
>+		return -EINVAL;
>+	}
>+	in++;
>+
>+	/* 4: 64 KiB, 5: 256 KiB, 6: 1 MiB, 7: 4 MiB */

Id reckon this would need to make sense for a new code reader.

>+	block_max = SZ_64K << (2 * (FIELD_GET(LZ4F_BD_MAX_SIZE, bd) - 4));
>+	linked = !(flg & LZ4F_FLG_BLOCK_INDEP);
>+
>+	scratch = kvmalloc((linked ? LZ4F_DICT_SIZE : 0) + block_max,
>+			   GFP_KERNEL);
>+	if (!scratch)
>+		return -ENOMEM;
>+	out = scratch + (linked ? LZ4F_DICT_SIZE : 0);
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
>+			/*
>+			 * The dictionary ends where the new output starts:
>+			 * move the last 64 KiB of both in front of the
>+			 * output area for the next block.
>+			 */

bit long.

>+			size_t keep = min_t(size_t, dict_len + ret,
>+					    LZ4F_DICT_SIZE);
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
