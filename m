Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221C37FF60
	for <linux-modules@vger.kernel.org>; Mon,  9 Feb 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652540; cv=none; b=nEKeBlthJCgL40SB+aiNhv6Zj4Ekwvnhi8MdnVVG/7Y3Mi7Cpy+cBSiM6dxC079p00uxr9MB5F6xpBqc0wTCJMQGCI/6Pldb6ZEVUVLEaBeF4pyKWg+SgkpEGsJDAbDaLdGVWsXjKokN5UUwLXWcvtKnP3OqWCgRpjb92FOr4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652540; c=relaxed/simple;
	bh=V8Rnhl8VIOBv3DuAo+TZ+IZMB15AZNGwMXeRFVARncE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cz1J8KS4xSwuv8c+kTQIe4o8HJ4mM5YITnDK4tCKafW3ksJ/34XBZ5W2j578BSAHrormh78WbWRPAW/1aX66sh3wzJeqE3S7qwpVk4h5PNEOm1wikM62WeCXlUtm7fs9NawHKMWX581IyMdd9+snoUQK+H6znvB6ZaW6pMWDSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlCRQ5z0; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlCRQ5z0"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711967e0eso1959285c88.0
        for <linux-modules@vger.kernel.org>; Mon, 09 Feb 2026 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770652540; x=1771257340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VskMGa4gmnAoQENP0aP1OjBfvfi8EqL345aEbaToA2g=;
        b=XlCRQ5z0eqT5wmZABQZEwU3IDX2tv2zvpa5pXUILU4gwZAjo3kFd8xd3WR5zGeKxF5
         0zLEUtUdNZcAFFhG4EbYZoJp14W/A/KCR6pFo8a6sp4+aCQ0lIL4gi5bq2Kk/xJeBuOc
         63jt6rgeMcRkqMRmvEJIjjr0/sLzONN0DqtV7LyG3YWbxIKfOnaz5T0/agp3r5qCXGRE
         HJlBNoaa/YpFimkU0w9C6Y0ED4zrY1c0eKEXT8Khv/VazT+b5x3fkCMQ2N3y1rWep2bJ
         yAWgTMDFuENrSEbDIvkYv1moTt38iUzBPKzl399n1dP+O5FWMaoqn34JXWXQDyQfgvHR
         q6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652540; x=1771257340;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VskMGa4gmnAoQENP0aP1OjBfvfi8EqL345aEbaToA2g=;
        b=PLMKZJnM5t/NXrrOvSSYb/+0Sj4wir3M8NVhJYTQEJnQEpbt/8FdlW/x5hpcLwyMh+
         /b5+lfANZ5RXrdl9XNibDdeySpGpBoyZ04hwxWa4Nt42BwBjhvQG5IEEVnIbbOn2GRHQ
         CvXNVaKxk9HK650A2Ous25/7nqQorGptfEqb9DVyOf8eW5nQDTYNoBGbH9YRLVHH+k3u
         0ZRlT+ONmVDCnEBXkUAG0S4V2SuK6TdJ38++S561HxxLwUfmnuM/EJw8J9E8Z4kGw++J
         +v8fiB5sLTu7zd2m5zgygICgIpmQriKR5vHRBSHWgGzP6BxARFZrRYvkGmRHWfA/mX1o
         +XFA==
X-Forwarded-Encrypted: i=1; AJvYcCVug4KhQvzVcuqasZz0fb/IWAm1fVj3Ktk1hBRh/I1zfHjZpXY0Ujn5EYhSPmNSEKq0ed1wNGq+6OwFTHms@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMReJrjW6wYB4bEl2mFq77IajnyQKAs57bHr5G5kQodSUxssk
	K/hPHulrHGJD90xT/fczTVXQCMmluYRIXHRdTrg/hG7JTqnaOnmDGaz6YOKexzCmcOSHyKNI0uZ
	ChwLnV8wGNblyXKM7DFLCVLt+h4FCUw==
X-Received: from dlbrb7.prod.google.com ([2002:a05:7022:f007:b0:123:12b9:c4e5])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:69aa:b0:11b:ca88:c4f5 with SMTP id a92af1059eb24-12704012098mr6074991c88.35.1770652539577;
 Mon, 09 Feb 2026 07:55:39 -0800 (PST)
Date: Mon,  9 Feb 2026 15:55:26 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6380; i=samitolvanen@google.com;
 h=from:subject; bh=V8Rnhl8VIOBv3DuAo+TZ+IZMB15AZNGwMXeRFVARncE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJldzPlvT/q5Gsln7j4W0dqac8bfW3W2m3iE48ntnnoHG
 q0et/J0lLIwiHExyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIk032f4Z7Eg7tLcmObvUgsz
 A/7FrF3nPMPLYknDHI7Ab682Rv1iF2JkmNi81f5SyF0N8zWZfc+nRE40j/0jE6Lzdq6teLx8ToY TFwA=
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209155527.1385229-2-samitolvanen@google.com>
Subject: [GIT PULL] Modules changes for v7.0-rc1
From: Sami Tolvanen <samitolvanen@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Coiby Xu <coxu@redhat.com>, Daniel Gomez <da.gomez@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc1

for you to fetch changes up to b68758e6f4307179247126b7641fa7ba7109c820:

  modules: moduleparam.h: fix kernel-doc comments (2025-12-22 16:35:54 +0000)

----------------------------------------------------------------
Modules changes for v7.0-rc1

Module signing:

  - Remove SHA-1 support for signing modules. SHA-1 is no longer
    considered secure for signatures due to vulnerabilities that can
    lead to hash collisions. None of the major distributions use
    SHA-1 anymore, and the kernel has defaulted to SHA-512 since
    v6.11. Note that loading SHA-1 signed modules is still supported.

  - Update scripts/sign-file to use only the OpenSSL CMS API for
    signing. As SHA-1 support is gone, we can drop the legacy PKCS#7
    API which was limited to SHA-1. This also cleans up support for
    legacy OpenSSL versions.

Cleanups and fixes:

  - Use system_dfl_wq instead of the per-cpu system_wq following the
    ongoing workqueue API refactoring.

  - Avoid open-coded kvrealloc() in module decompression logic by
    using the standard helper.

  - Improve section annotations by replacing the custom __modinit
    with __init_or_module and removing several unused __INIT*_OR_MODULE
    macros.

  - Fix kernel-doc warnings in include/linux/moduleparam.h.

  - Ensure set_module_sig_enforced is only declared when module
    signing is enabled.

  - Fix gendwarfksyms build failures on 32-bit hosts.

MAINTAINERS:

  - Update the module subsystem entry to reflect the maintainer
    rotation and update the git repository link.

The changes have been soaking in linux-next since -rc2.

Note that like Daniel mentioned in the previous pull request [1], we
rotate maintainership every 6 months, and I will be handling the module
subsystem pull requests for the first half of this year.

Link: https://lore.kernel.org/r/20251203234840.3720-1-da.gomez@kernel.org [1]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

----------------------------------------------------------------
Conflicts:

There's a linux-next conflict with dhowells' keys-next branch. Specifically,
the keys-next commit

  0ad9a71933e73 ("modsign: Enable ML-DSA module signing")

conflicts with

  d7afd65b4acc ("sign-file: Use only the OpenSSL CMS API for signing")

Here's a suggested resolution from Mark Brown, which has been applied to
linux-next:

diff --cc scripts/sign-file.c
index 16f2bf2e1e3c,78276b15ab23..bd269a2bbf26
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@@ -206,10 -228,15 +206,11 @@@ int main(int argc, char **argv
  	bool raw_sig = false;
  	unsigned char buf[4096];
  	unsigned long module_size, sig_size;
 -	unsigned int use_signed_attrs;
++	unsigned int use_signed_attrs = CMS_NOATTR;
  	const EVP_MD *digest_algo;
  	EVP_PKEY *private_key;
 -#ifndef USE_PKCS7
  	CMS_ContentInfo *cms = NULL;
  	unsigned int use_keyid = 0;
 -#else
 -	PKCS7 *pkcs7 = NULL;
 -#endif
  	X509 *x509;
  	BIO *bd, *bm;
  	int opt, n;
@@@ -271,20 -314,49 +272,40 @@@
  		digest_algo = EVP_get_digestbyname(hash_algo);
  		ERR(!digest_algo, "EVP_get_digestbyname");
  
 -#ifndef USE_PKCS7
 -
+ 		unsigned int flags =
+ 			CMS_NOCERTS |
+ 			CMS_PARTIAL |
+ 			CMS_BINARY |
+ 			CMS_DETACHED |
+ 			CMS_STREAM  |
+ 			CMS_NOSMIMECAP |
+ #ifdef CMS_NO_SIGNING_TIME
+ 			CMS_NO_SIGNING_TIME |
+ #endif
+ 			use_keyid;
+ 
+ #if OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x40000000L
+ 		if (EVP_PKEY_is_a(private_key, "ML-DSA-44") ||
+ 		    EVP_PKEY_is_a(private_key, "ML-DSA-65") ||
+ 		    EVP_PKEY_is_a(private_key, "ML-DSA-87")) {
+ 			 /* ML-DSA + CMS_NOATTR is not supported in openssl-3.5
+ 			  * and before.
+ 			  */
+ 			use_signed_attrs = 0;
+ 		}
+ #endif
+ 
+ 		flags |= use_signed_attrs;
+ 
  		/* Load the signature message from the digest buffer. */
- 		cms = CMS_sign(NULL, NULL, NULL, NULL,
- 			       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
- 			       CMS_DETACHED | CMS_STREAM);
+ 		cms = CMS_sign(NULL, NULL, NULL, NULL, flags);
  		ERR(!cms, "CMS_sign");
  
- 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
- 				     CMS_NOCERTS | CMS_BINARY |
- 				     CMS_NOSMIMECAP | CMS_NOATTR |
- 				     use_keyid),
+ 		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo, flags),
  		    "CMS_add1_signer");
- 		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
+ 		ERR(CMS_final(cms, bm, NULL, flags) != 1,
  		    "CMS_final");
  
 -#else
 -		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
 -				   PKCS7_NOCERTS | PKCS7_BINARY |
 -				   PKCS7_DETACHED | use_signed_attrs);
 -		ERR(!pkcs7, "PKCS7_sign");
 -#endif
 -
  		if (save_sig) {
  			char *sig_file_name;
  			BIO *b;

----------------------------------------------------------------
Coiby Xu (1):
      module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y

Kees Cook (1):
      module/decompress: Avoid open-coded kvrealloc()

Marco Crivellari (1):
      module: replace use of system_wq with system_dfl_wq

Petr Pavlu (4):
      module: Remove unused __INIT*_OR_MODULE macros
      params: Replace __modinit with __init_or_module
      module: Remove SHA-1 support for module signing
      sign-file: Use only the OpenSSL CMS API for signing

Randy Dunlap (1):
      modules: moduleparam.h: fix kernel-doc comments

Sami Tolvanen (2):
      MAINTAINERS: Update module subsystem maintainers and repository
      gendwarfksyms: Fix build on 32-bit hosts

 MAINTAINERS                     |  4 +--
 include/linux/module.h          | 18 ++++-------
 include/linux/moduleparam.h     |  8 +++--
 kernel/module/Kconfig           |  5 ----
 kernel/module/decompress.c      | 10 +++----
 kernel/module/dups.c            |  4 +--
 kernel/params.c                 | 15 ++++------
 scripts/gendwarfksyms/dwarf.c   |  4 ++-
 scripts/gendwarfksyms/symbols.c |  5 ++--
 scripts/sign-file.c             | 66 ++---------------------------------------
 10 files changed, 35 insertions(+), 104 deletions(-)
