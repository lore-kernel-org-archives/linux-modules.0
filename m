Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6E2673AA
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114799; cv=none; b=Ezr+2gCQlQx42UyJs8PrcYl+Q3dw6FHw0AE6YCg4gaaDrkpXM+/3N9MYPxQ+MCSt+9Spj+PL9QYiHE2pRGA4QoWzkuAWkZkpSCwMcq914d2UZTzgf1rmc0OIxTKMzHW/LEiOHbrd/CTHJvPXdoIpGl4BiMwhFzfP1fOS0EbjeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114799; c=relaxed/simple;
	bh=CHhU3OrOdk340qyqkitwJIqaC84MqZ7shflUGPh4pxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlcgsRjuBZsWC9HIZ1akDHnn2P0XKRBcGUvHRLEfHw+BDnwHl/Cvcel7ONuKPjFLBMqc0H9AUwYRAwoBf/iCK/AHhpM8PXOtoP62QkNy+c1N9WjY0iKymAAiOfksqDo4gRoYNKaj9Da7cGSxwoyEqC7r/61Ac39jvHzblljHtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOLKuC7J; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOLKuC7J"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bce386d5b85so361767766b.1
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114797; x=1779719597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbt3n/YhJ+P2VJtD3JU+1cQAnR79ZzwjF6VuK9LVFGM=;
        b=NOLKuC7J2pAbK9B2JLJd/uK3HY516XbyKgSiK1uzDIBlFPcTN6YyAcqL2F/+vRZMNQ
         dF9WwuzIq2NmFGATITetxqJFam8PgHFENk+Afh/DzMkPJSmyx/h0t8Pn/5hJdmd17+Mf
         8WxwaKlQcG9Su178SbgAJ+iQQSYbXuENlzaaQmGovCS0lkxLoaU4wlJ7mX97ayyki/Uq
         va5FTMtbwjgHh3TnBOudU/A0krUj++ACU63CbXfksJ7BbeCmnLmbPSH940SXAVVdvbP8
         pZxh9pF3qI8JZH5+AAW4eLl0+bBuVhghORSUdN3XNgSl2FKu3JP9PjSudTLK1qSBB4x1
         CdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114797; x=1779719597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbt3n/YhJ+P2VJtD3JU+1cQAnR79ZzwjF6VuK9LVFGM=;
        b=LkVJ6AVw5Cylx8kAnuG3U2rgalzYnUyPiMi2/PeS3UOaS2t/dmV9sog27KUt8SYG/i
         Y94p9QnJ4WxzK0YSYPW+5KKeiMCjRsjJ+zKWxbsv2hWaR++EcD/H4N6XflQfAdbEZtL9
         VcT/9qPR2oI41LfOX50/OxmPtj9aFWA7wRyht4ymiR+wPtFr/oIQJEmONgX1KbUzquB+
         vVOxZyV9izmMjt1Um0mHopzqq99gmWBep8k++VPK0GgrGh87AD7qmv3PyE/C7ud1t+/y
         DSytmYx4VCmzbYVmUgretswUFZL2mvNewnlDahNH6v+c9SAei5kcABOQlsaqRpy84u7o
         yJhA==
X-Gm-Message-State: AOJu0YwJcCNu0JoJXc2i5JBSCDOeaRSGOKi2KjhqqEhXapgTq6GTnNGP
	ghvOozOVeqp6zl89WiL4skFS/xWHlCQhFWBLzCemVS2mTHK+f4leT5+Mf14s+n41
X-Gm-Gg: Acq92OEaxNVfX4J2aZn/a+/xZH/WbtUO2KemZrAqvAVnF1iGQs/a0y/6sZpFK+RZEVU
	7aioG4GR5ZbbJZYfRVoMs0zKAclzvUBBRNy0Je2LLwc0cVaySiQxnYj01QCodcSgCiLRwa/c3/n
	t4swo6yOE538tj/HCn7xxTI26Hx5nG8rffs507AbC+5yt32xaJYUzJNhwfP7zqr6noaXyZJASXl
	ysndgUgN+YndrZbtq8awnZH/gF20DgH7Vj5hT/YwxJ/fIFzAeBaVCnA44H3UPpjtMAJ+zlYtZZe
	g9gDKmDYq3QciCQQtdrB387bblJLQYvDsaLvb+/gaOm/JyTVdFqDOnTy7gU4DfrsCHUbBPA/dmQ
	caAbAq2Rc8DMI8IU4aA+5+OnvX1dTlqpsuIE5/SjPfzW5WOUU5RtoP/Y8D4Op3PCDDEOo3T30co
	sYd1t3Y6H8w7RcxXKyLXQ3wcL6sjy30C1BxNS8ZEOKbQOmUkJhAR0=
X-Received: by 2002:a17:907:15d6:b0:bcd:53e5:c8f1 with SMTP id a640c23a62f3a-bd5177e2d11mr620050866b.13.1779114796477;
        Mon, 18 May 2026 07:33:16 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dee08fsm563732966b.29.2026.05.18.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:33:16 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-modules@vger.kernel.org
Cc: chleroy@kernel.org,
	mcgrof@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>
Subject: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
Date: Mon, 18 May 2026 17:32:33 +0300
Message-ID: <20260518143233.16091-1-capyenglishlite@gmail.com>
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
Changes in v2:
 - Remove unnecessary initialization of 'error' to 0 (Christophe Leroy)
 - Remove unrelated blank line after if (error) return error (Christophe Leroy)

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
