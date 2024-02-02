Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640C85936
	for <linux-modules@vger.kernel.org>; Fri,  2 Feb 2024 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900914; cv=none; b=DYuuz9ZMiz97irUWN+GtB6gHZigka3q8jjJ1LpTizG8lDDsRKVB/uN/X0Wu776EgLDa/y5XJ+vUNrgqt/Vsohd8kyXtm86gcGPZJ90r4YqKtAWsZtB+4dpAhT8dLDNmd2WrpRSl0QMAt/b8Hm1kYG3YGuqseKWnreg3JpPaH4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900914; c=relaxed/simple;
	bh=WYihhoZycDKb8f5YaEFOdWsw/ECW4R4hSvKZEZrd4g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOuwJRzIYjz7HzEzwBQ/9a/ZEfp9AQKyMBDK02wdF6EIZ0iS7FMjMpEaWkmd/A73NTVXBMNndMGVB2Syq4Ng++4e6suA9qnWD0io6qYc1hzdfWq7zIP4y3D0mdAxk+xS0Hiswy0chueJxPwa/V72VpDPyfnkmejIsNinuYVjVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFBynMDn; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFBynMDn"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783f49812aeso100009385a.2
        for <linux-modules@vger.kernel.org>; Fri, 02 Feb 2024 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900910; x=1707505710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khGzB73ScNNsYbD+NU6AwB881Cdb2ZP7KKfOQrLkREs=;
        b=CFBynMDnFh1TA/QLiNEqhTulyUfVi6Mc6GDOtKvth47eugCgD8BBuCpgNkHNNDMWb/
         50dVIADnaOEWRm+6abOQAGAtygMjZOl+gWmSHijClieDNgKvPYKqtyyYO6QARw/BajzT
         6v63kAzNt13oAaqNlhUnG3MrQqBL1n05dn/U+aHQ+5LFuxGeA6vcO7SYQES7b1n03ZFK
         CvlyWKii+UJ6oMZhOqAenQcWdCgOHnwDcxz8re7pwW5jYF1+k58OHB7BcbfefFafxubp
         J8SvtiGZsGVBq0J84nymK5VTKVWy7Lspf7fSCFyf8RIG8BuUMLkO1Pyc61qtGMk05MU/
         ZyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900910; x=1707505710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khGzB73ScNNsYbD+NU6AwB881Cdb2ZP7KKfOQrLkREs=;
        b=sNuXkUGexGZL0ZaLEYT1nCradQfLyCPRvPQKCLkU9dIZ0rEQEqIEEKOYK9dnOG4NFf
         GqTDVQ2QZovH1JR4hZPh2JBab67NnTD5+iPqddgEiSshB/f/du7Q6BykbgbhAcmCQDHJ
         CwPv8ILouPfWONdSgKZNU2P9Rr7fafkF/Gudv3Gk0Uknns7raIqLQ/0IPSRhyDJU2Tos
         RPMPcZrdrtB0wwGfg9M9klRB/1RW6t/p2lsbBLrA20BEJlhQnUeZKFJlYFQa7TnhKB0B
         XZmarh5TBQgAHXTzjn+hdo1q0H7SdC3opoWymrgpnVSbnZK7z7MDKJ+crqcJL/5TqSWe
         U7AA==
X-Gm-Message-State: AOJu0Yw+SLQcw01m+mj9pxyuL2IwcU56lFblx6dnDif95/sreXI2T7Tx
	prbEccV2QczjGqCLSEElXs8ulkIbpnuMRSRt8Z8YfIHWh6sFa+mDANMJBHX1
X-Google-Smtp-Source: AGHT+IGRMgZyGXgtcuV+jguJ9eTRt+NOUtc01Fp5JcCx04CJ119Uns3CqA1mZpaAb4HypUS15vNQxg==
X-Received: by 2002:a05:620a:8cb:b0:783:fbc1:9c25 with SMTP id z11-20020a05620a08cb00b00783fbc19c25mr2721249qkz.36.1706900910424;
        Fri, 02 Feb 2024 11:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHeRKqSRqjRIe+hGEctkCzhwXqsmreYc/zxZjiFX0kDcP4SiI/g9IQHMpPlhp5gOAIp9skL/jFQghxlktBXClEEuCJ8qOPD5c=
Received: from ldmartin-desk2.lan ([192.55.54.51])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a15a400b0078408de98e6sm903011qkk.72.2024.02.02.11.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:08:29 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 0/4] Drop what's not maintained
Date: Fri,  2 Feb 2024 13:08:19 -0600
Message-ID: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of these were long due, just not done since they were at least not
broken. However the python stuff was keeping me from succesfully running
`make distcheck`. Even if this is fixed, it'd be probably better
maintained somewhere else.

Lucas De Marchi (4):
  Drop python bindings
  ci: drop travis config
  testsuite: drop mkosi
  gitignore: Ignore *.pc files

 .gitignore                         |   1 +
 .travis.yml                        |  33 ------
 Makefile.am                        |  82 +--------------
 README.md                          |   3 +-
 autogen.sh                         |   1 -
 configure.ac                       |  21 ----
 libkmod/python/.gitignore          |   6 --
 libkmod/python/README              |  23 -----
 libkmod/python/kmod/__init__.py    |  24 -----
 libkmod/python/kmod/_libkmod_h.pxd | 113 ---------------------
 libkmod/python/kmod/_util.pxd      |  20 ----
 libkmod/python/kmod/_util.pyx      |  28 -----
 libkmod/python/kmod/error.py       |  18 ----
 libkmod/python/kmod/kmod.pxd       |  22 ----
 libkmod/python/kmod/kmod.pyx       | 125 -----------------------
 libkmod/python/kmod/list.pxd       |  25 -----
 libkmod/python/kmod/list.pyx       |  45 --------
 libkmod/python/kmod/module.pxd     |  24 -----
 libkmod/python/kmod/module.pyx     | 158 -----------------------------
 libkmod/python/kmod/version.py.in  |  17 ----
 testsuite/mkosi/.gitignore         |   3 -
 testsuite/mkosi/mkosi.arch         |  26 -----
 testsuite/mkosi/mkosi.build        |  38 -------
 testsuite/mkosi/mkosi.clear        |  20 ----
 testsuite/mkosi/mkosi.fedora       |  28 -----
 25 files changed, 4 insertions(+), 900 deletions(-)
 delete mode 100644 .travis.yml
 delete mode 100644 libkmod/python/.gitignore
 delete mode 100644 libkmod/python/README
 delete mode 100644 libkmod/python/kmod/__init__.py
 delete mode 100644 libkmod/python/kmod/_libkmod_h.pxd
 delete mode 100644 libkmod/python/kmod/_util.pxd
 delete mode 100644 libkmod/python/kmod/_util.pyx
 delete mode 100644 libkmod/python/kmod/error.py
 delete mode 100644 libkmod/python/kmod/kmod.pxd
 delete mode 100644 libkmod/python/kmod/kmod.pyx
 delete mode 100644 libkmod/python/kmod/list.pxd
 delete mode 100644 libkmod/python/kmod/list.pyx
 delete mode 100644 libkmod/python/kmod/module.pxd
 delete mode 100644 libkmod/python/kmod/module.pyx
 delete mode 100644 libkmod/python/kmod/version.py.in
 delete mode 100644 testsuite/mkosi/.gitignore
 delete mode 100644 testsuite/mkosi/mkosi.arch
 delete mode 100755 testsuite/mkosi/mkosi.build
 delete mode 100644 testsuite/mkosi/mkosi.clear
 delete mode 100644 testsuite/mkosi/mkosi.fedora

-- 
2.43.0

