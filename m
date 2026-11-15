Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754596;
	b=SySPdBOPmmytziwMzVbZOBCXOYKjoSTP7gm1iH6X/DN9WlbVZBcPeCKhEKGt2tOcLG3k
	 aR3kSusBgCrLIlIonBu3H9E+PBVlD5TC7hzCoM6lOT7jO/1HoWExzAzJXYuk6kDNnytP0
	 OTxeejmMNtaHSS24v5QZGnozP+1vvCql9pMnykozQaeIWPvm/EeGWjPZwhCaK9Vw+D7Js
	 USSNF55Ja7O8Wr51oTqKXSqOGkGSmrMxttk5JMvZLzQLsQZo87TTz2ao2sdGBtiXcvljw
	 F8+skZhMkPWqgRj05MZEozb7jXW+mFkKpE2zcg+v2rugeRm6pRvMkQrccdfyaTEIhxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754596;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=hlQkFYMUmOSzD0lV/MmKoqgoD5EZFAViZ3TfGoz2DyE=;
	b=wnmvcdlIiW3qduyZhJLbuiqy9IyPkrdbc/09cb/OvebxanHQsfE6UOWJupXu8lBAw+Vz
	 yYRkZSoEJy12QbupXjhdHorKbuPr8K8WzmZCLKc9R7wgS74QF929KM4mlHKqdXorIrj4l
	 jN8IyUcDVfuYwX4DQYQsc6qU3Icj7rc/jkrCs8H39QqMFssxvQPauhLjfuEM1nIHn4eZ3
	 l0zHuSiEntFuZa3sFxpeh9rqvk1UH31r4XDGAiwBgcpORZMN6qDq4r72eMk99BkLmlAib
	 y1mdFvY7PlZMEJPDZ/1edEOjV1hOuj+7qb41xXF2LryNUUfnldg9+cSqyW+NTh9iF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=NzkoSdV+;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D00606A31D;
	Sun, 15 Nov 2026 14:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66D00606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=NzkoSdV+
Received: from abreu (unknown [62.214.191.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 454034C442F7F1;
	Sun, 15 Nov 2026 15:56:07 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Piotr Gorski <lucjan.lucjanov@gmail.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] module/decompress: Use ssize_t for the zstd decompressed size
Date: Sun, 15 Nov 2026 15:55:56 +0100
Message-ID: <20261115145559.262878-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794754568; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=hlQkFYMUmOSzD0lV/MmKoqgoD5EZFAViZ3TfGoz2DyE=; 
	b=NzkoSdV+zCaiy/ZONvldJSqu57+w/Bp1BDuyMk++7CJs8IjY4rsQiuns2rjVW3/5JjzFDu0lk4qp
	GBPKAHlGxn/bKukgr4Sgf75KbBkUDx9NGUoOgMuTG15IFnXAg+V/2tVb1jXArAuvg8fESmLU8tz48/
	KqNmnfm75LrHx325I8H6utagcmtF6l+XMYnS4s6RO7dX10B01ihTi3Tf4Fq9/7uuHM1JjP1duNQ9bB
	Qf6zDlYHx4w9K8zNDFhgnPEFhinS/9N9TpvESvmjmesoRLz+XzRm9WeS+8QZN9kVRxkSA8UY9EHxun
	VQ9Xdei1DxV0WQ3S1wY6R2tGApkM+LCg==

module_zstd_decompress() returns ssize_t, but keeps the decompressed
size in the int retval. Output of 2 GiB or more becomes a negative
value that is not an errno, and output of 4 GiB or more can also be
truncated to a positive size smaller than the pages mapped to
info->hdr. Declare retval as ssize_t like module_gzip_decompress() and
module_xz_decompress() do, and print it with %zd.

The Sashiko AI review found the same bug in the proposed LZ4 decoder,
which is modelled on the zstd decoder [1].

The x86_64 build boots in QEMU/KVM, and finit_module() with
MODULE_INIT_COMPRESSED_FILE and module.sig_enforce=1 decompresses the
237 .ko.zst modules without error.

Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
Link: https://sashiko.dev/#/patchset/20261113144233.193782-1-pmenzel@molgen.mpg.de?part=1 [1]
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    Claude Opus 5.5 (Claude Code) noticed that the zstd decoder has the
    bug Sashiko reported for the LZ4 patch, and wrote this patch and
    message. Tests: W=1 compile with GCC 16.2 for x86_64 (Debian config)
    and i386 (tinyconfig), both with MODULE_COMPRESS_ZSTD. Run time: the
    x86_64 build boots in QEMU/KVM, and finit_module() with
    MODULE_INIT_COMPRESSED_FILE and module.sig_enforce=1 decompresses the
    237 .ko.zst modules of a laptop's boot set without error; 223 load,
    14 fail in their init for lack of hardware, as with xz. The bug itself
    is not exercised; it needs a module that decompresses to 2 GiB or more.

 kernel/module/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index cce098671be97..ac4ff0e04f716 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -216,7 +216,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	ZSTD_DStream *dstream;
 	size_t ret;
 	size_t new_size = 0;
-	int retval;
+	ssize_t retval;
 
 	if (size < sizeof(signature) ||
 	    memcmp(buf, signature, sizeof(signature))) {
@@ -276,7 +276,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	} while (zstd_dec.pos == PAGE_SIZE && ret != 0);
 
 	if (retval) {
-		pr_err("ZSTD-decompression failed with status %d\n", retval);
+		pr_err("ZSTD-decompression failed with status %zd\n", retval);
 		retval = -EINVAL;
 		goto out;
 	}
-- 
2.54.0

