Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8F402BAC
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106786; cv=none; b=Ew4aa+NxqNPWqm/F5pGbK97u4OHWLWGN9wgJQYU2Sprt+mtqTnkPhumKqsLwYjRdKp5OCPXOqUX01LRyxdLszh7DXv58DbhiOnuWrTJhQRZKNkl7QapVw5+p09Vtys5LbNhbNSySoYGclqZRAQHj6W/Y+uMy0y/BA6z+fZ9MKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106786; c=relaxed/simple;
	bh=eLcdcZxrys2ehNx0yNlSxMilAqifYutDFaWElvOpaFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxGE45FvHEJgxDoLPJRzbAo6PMOk5EY2hcMb0NJ5lLP3jV3xAl3ZOXaVVvv5ndIVwLLF3J6IjYYdH991qWaZIZshS5iStuAcwD9DavXTvdlIDZ7KF+rHGjw5B/fpbaicEuQGzbeHpamTKvV2Xw3yYRd+mzEAAQhy/fDL7qkbHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPKk2ezY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPKk2ezY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd373f83042so453101866b.1
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106783; x=1779711583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVDi3PTBIMFWhncpu/t25cZzFWgAxfyBAa2471yPkMM=;
        b=OPKk2ezYSFGkS8dFH9tW4Xd6KdpAdlQmcpKRYtqssEwQPZd2ZC8nOlC0vl9gkeEP+2
         avMmUFGnU/nuR08jdlTsho5YJ6ytzB6t0mSKtdWBscD/b8afGcKIJPGzKbj1fIl54bDC
         TbyG83AvgWSSJSOamOZZXc5AyVZtV1R5j5U/K9TK1URqJFkTpz33A8IoiG1XLqRvOVMm
         EvQaZuNr8u4l4HCvNqdicMhsqteF658Wo1VBMWqCmDLM1HYGuLF/cHgZlxHDDqfYlz/w
         SGYcJEK2y2B4e+I42nr/0mHB8ZN9TO4KogNwPxw1ZyJaBeE0EGc2KLt0Drhz1pIOHu9p
         Zhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106783; x=1779711583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVDi3PTBIMFWhncpu/t25cZzFWgAxfyBAa2471yPkMM=;
        b=Ph9ES5Qx6UmGm87lZrcEBPkdtR5BNwemalW24m+OXzDFovMfRVdJe86u7k7asfHohA
         e4YX5q2KB/ZCZ6L5m6OuL3ML8VHrIBDjfV6C5kRT5YVZHqYKJkndB6bSK7yuM+lMqi/D
         Tu/KBZUR8dJVGkJ1rY+8ybZW0Frc6D7YUrktyf2nwoBIP0Qpw7KUhfpYdp99rrIK9Xo9
         Se9BqlhAoA7D7x7CLjykpvF2bYdlM7xU6x5SbP47+qu/J5mtch8QhEFV1My+fiGZXFaV
         3dJ47QdcjQX6XkgrIyX4wx5Q5LkI/myhifVCEwbWt2IkCZaDmArvezNGvPGFoBQuX0yc
         sd9A==
X-Gm-Message-State: AOJu0Yx3qttkS7HWwPFwnqQ3DU0sFKUnHw2F4oHBboxeQxr9r+Y2AqY1
	E5rE/S+iGB03w0jFP3H81/kgw3iIsu+5xOhuvt/thge8MA5YhQikh6OOCSmb86cu
X-Gm-Gg: Acq92OHVZvvkz0PiBVvKn9nP1e0Q2WMJWAZhPy9nmbDiICQ3WCNPvG0/HXJ/NqhiIEM
	CmajO7yl436puFh1eWKSCbjYCrRB30ILVkgtfITMpBCNuTM+mUysDDUUevUX0vj6H47V4n2Qia8
	7izqZBgxyDA54xO44qdtdtWxCeCa+fDqL0v+j672TQMUN0ZNc4BE6QhvWGgEvfFjOUXZE8JzJo6
	kfLz4GBJTC5ecbO6YHGUhwlXeqLd1NSQo/SWkMjyyR/xS96ExczhViN4AIrQ5IpwjOGaReKZuAP
	fkn4YyUejxdlVA10A5bX58urtlG5NYTZ5U6JCJta0pTnk6508M9TgL3dkorIjQqnkKC65Xx9fry
	fwYhUFlE7ypYwfv+jndaBabkfzYzgZtGHrIpROwF/G7ws5mNsgbMREvSFJnATcs9rFKui1lIJW3
	ya4kSlCpOPMej/epfHHDXjubWnd56Xow==
X-Received: by 2002:a17:907:3d11:b0:bb9:c23:573d with SMTP id a640c23a62f3a-bd517964d61mr715072566b.31.1779106782560;
        Mon, 18 May 2026 05:19:42 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bcf7f3sm551533266b.2.2026.05.18.05.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:19:42 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-modules@vger.kernel.org
Cc: chleroy@kernel.org,
	mcgrof@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>
Subject: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
Date: Mon, 18 May 2026 15:18:58 +0300
Message-ID: <20260518121858.3071-1-capyenglishlite@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

module_extend_max_pages() calls kvrealloc() internally and returns
-ENOMEM on allocation failure. The return value is never checked.
The decompression loop then continues calling module_get_next_page(),
which writes struct page pointers into info->pages[]. When used_pages
reaches the stale max_pages value (not updated due to the failed
extend), a subsequent write to info->pages[used_pages++] goes out of
bounds into adjacent heap memory.

Adjacent slab objects in the same kmalloc cache (pipe_buffer,
seq_operations, cred) can be corrupted, potentially leading to local
privilege escalation on kernels without SLAB_VIRTUAL mitigation.

The call order in finit_module() is:

  module_decompress()    <- vulnerable, runs FIRST
  load_module()
    module_sig_check()   <- signature check, runs SECOND

Decompression happens before signature verification. A crafted
compressed module submitted via finit_module(MODULE_INIT_COMPRESSED_FILE)
reaches this code path before any signature gate is applied. On kernels
with module.sig_enforce=0 (default without SecureBoot) or with
unprivileged user namespaces (Ubuntu, Debian default), this is
reachable without CAP_SYS_MODULE.

Confirmed present in mainline (tested on v6.14-rc3).

Fix: add the missing error check after module_extend_max_pages() and
return immediately on failure. This matches the pattern used by every
other kvrealloc() caller in the module loading path.

Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
---
 kernel/module/decompress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -XXX,9 +XXX,12 @@ int module_decompress(struct load_info *info,
 				const void *buf, size_t size)
 {
 	unsigned int n_pages;
 	int error;
 	ssize_t data_size;
 
 	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
 	error = module_extend_max_pages(info, n_pages);
+	if (error)
+		return error;
 	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
 	if (data_size < 0) {
 		error = data_size;
-- 
2.39.0
