Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5F53176EE
	for <linux-modules@vger.kernel.org>; Mon,  3 Nov 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186806; cv=none; b=U9Po+MunbvURu/BcsFRjLxePIzt2aS3SppauAzX/xzmU7cgRh8T4+oiQjiW3lAkktOQX2UJAkirEDRrAzb0cC3e3KaU84nIwEdbVtT2gisbYprGbX540wtZOxG19JWeYnv1PXQ6vQv825jWTytvJcc3X5bKdxLQ+4LaVZ7NMK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186806; c=relaxed/simple;
	bh=h7R/k1MMSVPQfBxt0pvy0030CquRgbNXX1VOTDMoaIQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rsCyf1ev+0QpqqaHhrft3YrtVXJc5GdlhZNk4IseEUp3vdSYBZvDMl2G1QuzD+hJSLb8AibCVrF6ZY8emXIri04WYOEyyDj9KiuVGwsd3d/cPTXXogTFNffsJ2d0yFkkdN+oTqAEtAP2XruJejZv+R31LgKt/1QMwvGnFiZKzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj09nGBa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj09nGBa"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477171bbf51so24650645e9.3
        for <linux-modules@vger.kernel.org>; Mon, 03 Nov 2025 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762186802; x=1762791602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8tTM2uCb0zl0k898LdIZTakN1ZygKd+3CMbo77PL78=;
        b=rj09nGBaFeX9xJxGNhVti1JlVGg35iSsZj581DpbIM5CayFWU0a8FRWSK4VebK7qHu
         Ux+y7H3SBxbIMMw9l7HyhN7Ptva2mSJhoC1VSqLuECr8c9NxHO9OT24T4rssf+DC3l4s
         wG/3HPFQP1bi+Nm1IMlehvS1erGMmZ1i8AlRbxXVxR0SuoaVwJ9avqqZTTYVgNf4z8+c
         X0kE/cWi2A52pNCxV6BG9vfj49Ss8qMjosifq2Sa8P6+wD4YW0jhh7Os4pN8CLUXbfjq
         4Z10drFG4KKLrxMdHOK+CXi44cRaLGDIecz3PkEHdqJnO616SPjAVuVmtTFqYEOqhzOm
         1axQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186802; x=1762791602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8tTM2uCb0zl0k898LdIZTakN1ZygKd+3CMbo77PL78=;
        b=MsFIXHojZ0SdzFIi9xg74UFlAkA0y/7UpeSLa8YeWWLWV9CUNsM7ZG7VTCTIXH3imy
         UI5Iyk6uvc7rFF9x3ltGGze/PoVdpdselxUvflEhg9G5odCPQuTz6OUqOg9wu/uYBDdm
         Pyor7kXb4IdXY8K+jBzd3XyZzBIEPQfXX1EGW+0QqSerGgEhSd1b1F82EGqZQDcBOZKS
         /BbTH89hMDCYeJMCe0m+Y9KqonpGQEO5Aw869WsoQEeV4ISB4ftkfe4I4KInNfrG/PXw
         0dGbcqqz67YFVAemD7csWZprrXRFbc1twd8bf+bXYtCisqXp0N/+N6PxZd9sAXnOxS3E
         gH/A==
X-Forwarded-Encrypted: i=1; AJvYcCXgc6TcMS7eAnhCGP6wDgoD3StaOF44UCtcfBjrjIGOyXYqUekjU/4HAIfnHjLma4yiSEltWvld2512XXHN@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQrY4+PUJxv0vbA4acwImkwnHrO6tV9DZA6ig/vmat8q8fXfq
	M/fPxZKQVKzMvtF9eB/kbtT5QWSHJI/lp6k7KxskcsrCnlMR9GNALnuUFRrckx4WCRCfuexoHNL
	CY979HXeV2sSzaq4RyA==
X-Google-Smtp-Source: AGHT+IEbhSxEl23KciUSXJmUxlryd+9/wkj5PORgK0VgJEd3vZvStNFYMjkCuoAO6A/1vErUZgMsibakSlGcVNc=
X-Received: from wmwn6.prod.google.com ([2002:a05:600d:4346:b0:477:3fdf:4c28])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b30:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477429d8ee4mr73769555e9.30.1762186802499;
 Mon, 03 Nov 2025 08:20:02 -0800 (PST)
Date: Mon,  3 Nov 2025 16:19:46 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103161954.1351784-1-sidnayyar@google.com>
Subject: [PATCH v3 0/8] scalable symbol flags with __kflagstab
From: Siddharth Nayyar <sidnayyar@google.com>
To: petr.pavlu@suse.com, corbet@lwn.net
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	samitolvanen@google.com, sidnayyar@google.com, maennich@google.com, 
	gprocida@google.com
Content-Type: text/plain; charset="UTF-8"

This patch series implements a mechanism for scalable exported symbol
flags using a separate section called __kflagstab. The series introduces
__kflagstab support, removes *_gpl sections in favor of a GPL flag,
simplifies symbol resolution during module loading.

This series previously added symbol import protection which aims to
restrict the use of "protected symbol" exported by vmlinux, as a use
case for which __kflagstab is being introduced. Such symbols are only
allowed to be imported by signed modules when symbol protection is
enabled. This functionality requires more thought and discussion [1],
and therefore I will create a separate patch series for it. In the
meantime, this series now only focuses on introduction of __kflagstab
which right is an improvement to the module loader's code health [2].

Thank you Petr Pavlu and Jonathan Corbet for their valuable feedback.

---
Changes from v2:
- removed symbol import protection to spin off into its own series

v2:
https://lore.kernel.org/20251013153918.2206045-1-sidnayyar@google.com/

Changes from v1:
- added a check to ensure __kflagstab is present
- added warnings for the obsolete *_gpl sections
- moved protected symbol check before ref_module() call
- moved protected symbol check failure warning to issue detection point

v1:
https://lore.kernel.org/20250829105418.3053274-1-sidnayyar@google.com/

[1] https://lore.kernel.org/cac5ed5e-3320-4db0-99d8-ea5e97e56bfb@suse.com/
[2] https://lore.kernel.org/2bf54830-ea9c-4962-a7ef-653fbed8f8c0@suse.com/

Siddharth Nayyar (8):
  define kernel symbol flags
  linker: add kflagstab section to vmlinux and modules
  modpost: create entries for kflagstab
  module loader: use kflagstab instead of *_gpl sections
  modpost: put all exported symbols in ksymtab section
  module loader: remove references of *_gpl sections
  linker: remove *_gpl sections from vmlinux and modules
  remove references to *_gpl sections in documentation

 Documentation/kbuild/modules.rst  |  11 ++--
 include/asm-generic/vmlinux.lds.h |  21 ++----
 include/linux/export-internal.h   |  28 +++++---
 include/linux/module.h            |   4 +-
 include/linux/module_symbol.h     |   5 ++
 kernel/module/internal.h          |   4 +-
 kernel/module/main.c              | 102 ++++++++++++++----------------
 scripts/mod/modpost.c             |  16 +++--
 scripts/module.lds.S              |   3 +-
 9 files changed, 99 insertions(+), 95 deletions(-)

-- 
2.51.1.930.gacf6e81ea2-goog

