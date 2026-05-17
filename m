Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3934A76F
	for <linux-modules@vger.kernel.org>; Sun, 17 May 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779015693; cv=none; b=CL4JzACLW4IJIgiQhF0QV06ejeeobWwE8NOwhEt52MoE6bWKPkP1MZFSAVobPb154YCwmck+R17oPJlO1oQgJRVj9VtwE3RUXDNUwxBJiJtIXZLZfdZlbtCDG96qXJs7ZAvTqNXtXed4UDGB8A+E9q0hIkU/b21x9kDRXo9Qy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779015693; c=relaxed/simple;
	bh=5iTJ6uUs213eNLp86NK1cVHRd1P1kMFXqZ3zZMN3vh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWqzzb0nQwQcBRqO3uuQuA/hZ4fh/W+zDpfXlzbC4UgjaGIhNlstAA1lNaj/RJnd8CooI2cd2wfQnzxZHRzDBhisn3kKB+bPeh51lFaOmeIe0kIq5eVYmVrzyxDGA3vzxykttD62SWA/gUS9t1gJLo+CpXcg8FdA3Ezu8dKsAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgNrJ1F6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgNrJ1F6"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd11a3729e8so217720366b.0
        for <linux-modules@vger.kernel.org>; Sun, 17 May 2026 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779015689; x=1779620489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgEt85dKjR1TEekAbfA62AOLv8dJx0ApoYmsOz+B63g=;
        b=GgNrJ1F6bpN1hiFSy5xi6WVSDXq8e6OP4CXq0Jbmc/jna36n0NxZnPhF8xckdDosIG
         Ba6zXCuLpCtSs3NVcxoPAdTOLZ/fwChDe9GuM3XfPbtVMo1lZSKiUjFwlyIpxQDvbwTj
         JxZL7LV1US+L2pyltnlx0V8kkpZsH/mHz5atGkM6do8EjtF/hlRz3Dip21XjwM6A72rQ
         rel8qyhOktBc2gwVr3WTaZ1ZdO1hOkq/SxV0qFj+FzIF5RnaCuv5L6qsTFV6g8ubbUx3
         IwTSdQ+GzwDHB5XgmfKY7DOvVurRohpUPMFt57SRydxHNZrM5SrP3pddCzoUezXsirpL
         F6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779015689; x=1779620489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgEt85dKjR1TEekAbfA62AOLv8dJx0ApoYmsOz+B63g=;
        b=jXPn8EoE6VC6WGaEF9tnI3SncJIKYU++BmNroNQ3U/VLvXUj+cJm4dDtSGMe00Jxs+
         pRLbzRckNiOrRaP1cyC4669F5zeHnCa2fnWoNBZernkN4W157cfpnTh78q/1K3arHlHa
         HSgt7Z4ADuITmNRuf7GQGOV010CeCeQSCVEs6K3cMGETdCzcSjFdAJSzmRYwRAIMFjVd
         E6oNymtbDR9hViNMYnMOozfIDfQrpdBDD5sEasZgR3XkEP3oc8DFR5Yfnt3hKPZY6+Zy
         Ev9FUpC+R9nxmZwdj7Hc+1aoePgodAnlQ3mKvIoke7TCtAFCD2R0sGCEBF+dDkHV9e8x
         c02g==
X-Gm-Message-State: AOJu0YwThUTuKulmEnHh8QMqCl8U1c0quKlWCXwvcgnS9VkPhN8Jk3uB
	LIaJfFKTEdFYnB9C/d6oMZpRdWs9Ff9ER3qnZQuhSni1gx1gCUjS/I/Y4SjisHsf
X-Gm-Gg: Acq92OG6JCGNFe5cEDJg4DrjpJLUcUzpQdxKbLQnR9T5IMn788YVq3q5PeYKz7Idufm
	j/P8prLboy1XKMNMzRKWqu/gQZPD/z8NbbKQU1YftfyYFeSjMI1BMfXp/Z1eYuSTmYk1SY8bz0l
	fL6TnwkuwnX9/cdAXr/jhcSyfOzadvGLI0Bcv6tL3Wim6BIEAbdSldgJ2Ce5e8BNrSu2mCIpdSe
	/U86mB6oX/TdHFxrCPOphWw+biAyiwR5i1pwQKIfkAsrzu4IFB32+rM7dg6dsFC2HBEuRBYAICM
	8b0Eb6FfiBwEr6OrE6kDOssTILOeyis+YXwVq0f6uX+p+bDawvO4StXep8j+a9Nnq6ciVPjoPMb
	KyYCiEeEbIjqhNo3/tm3QfBJf66bVtL4A8g1mMdodjTpsrtUCUf+Z9f5W7OcUtdhMrPMD38XPKl
	4WWdG1uCCQqJsbu0HS50yulTqeOFCaFw==
X-Received: by 2002:a17:906:6a03:b0:bd2:875d:a8d1 with SMTP id a640c23a62f3a-bd517955151mr502673066b.35.1779015689078;
        Sun, 17 May 2026 04:01:29 -0700 (PDT)
Received: from nixbug.lan ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e4d54dsm435800966b.47.2026.05.17.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:01:28 -0700 (PDT)
From: Andrii Kuchmenko <capyenglishlite@gmail.com>
To: linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org,
	Andrii Kuchmenko <capyenglishlite@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] module: decompress: check return value of module_extend_max_pages()
Date: Sun, 17 May 2026 14:00:37 +0300
Message-ID: <20260517110037.21506-1-capyenglishlite@gmail.com>
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
 kernel/module/decompress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index a1b2c3d4e5f6..b7c8d9e0f1a2 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -XXX,10 +XXX,13 @@ int module_decompress(struct load_info *info,
 				const void *buf, size_t size)
 {
 	unsigned int n_pages;
-	int error;
+	int error = 0;
 	ssize_t data_size;
 
 	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
+
 	error = module_extend_max_pages(info, n_pages);
+	if (error)
+		return error;
+
 	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
 	if (data_size < 0) {
 		error = data_size;
-- 
2.39.0
