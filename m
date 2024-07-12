Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291343C062
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815632; cv=none; b=cRkBdYaFFAKhyBbSMYOr3oC3r/rSw/4I7xcrGTyNghQpIx/4cCXN2Ju7/x9ZXJPK98zbjLcqLtbyld/dF6Ziig2WgOfCFYNgHG/fhcAFY3iTNQw5VDQmgkKnCkHRAcLw8gjpWyq25nKlVs82I/l2K9+S56itriQhHmGEAfHrjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815632; c=relaxed/simple;
	bh=jgd6Ar3mjHxEU4gvhyzDWcNIBSGlMr5exCrEb4AilVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6bKQrkiE5TW0J8BUMt/yOZNztyb7MlBsqwUTeBCEKOfmMJiY48KEdX796dhIvkJVf19Oji6+RSasc+xazapjeMmoG2dQwqO6rHdNFJgTQPCOt1xg6unOAwmxNci81Ul6xGURfATiCKEH/8RCg1+pKIo6SUL9irWpRfaspRBzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k17lnnpe; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k17lnnpe"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79ef82c6391so127048785a.3
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815630; x=1721420430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsayz27AEK0ZUF0FdWJVnVPT8Q1Wqz0KnZfkRPataDo=;
        b=k17lnnpe+XV4wlk1YOMr3zPnxZZwTlQKMz5jkbyb8stRWnU7MXs5rJcUxBWJZ8BbRU
         lorf3+30+cACOmFFYD7AoQ/p3Ecy0wITkSStcy8T8i712o87fVDoGCgVwJcQ2gfL9QkM
         JThRIe06rulR0GGzl8J2/kuQScOYH4GMkOOxhdOKlkwutG8IOTnzcys7KQxDTvYqla1+
         If4G141wEV6LyICvAjJpuuodqNbsX+jw7a4v7duXZ/bqPVO4VYNZtzaB+NJsaommWPaf
         2OpyQvjoGKH622NkfqDBK8msi0GO4j2PrkqMg3lbzuzz4TlCXw1c7jXIUWsKdHQaUvLf
         fBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815630; x=1721420430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsayz27AEK0ZUF0FdWJVnVPT8Q1Wqz0KnZfkRPataDo=;
        b=HKfw6DAlXzDnFNGb4GaVBmgivjGttZZumsasO1+K/aJFpRw6IOuN39k/EER0qHzB1l
         zrd05TubSbXsbUL4OByrpjHaxOSxn+r3vbGyUIV+FxKl2Nn23vKo4C8s6HtkqAlgzSCu
         7INFSxY8xc4CX3ZRBuKSihBSg/ddnWz6MZT386QhGBUkFgOR5X36RSQ6oAE3jW+lpHZj
         /KxNOyCARwTFcWoAwz0q4cwyGwNUMTLkw3lKFthoPT3PRHROadDmRwg5bFj5CEtjDlD6
         BThTzl5XwShabPhKhPFuibYXaoNuDIYGZeQDoA2vXsPFBc0QIsQpOnLn18scW67bk/Dg
         7zHA==
X-Gm-Message-State: AOJu0YzhvTt2sCJEWm8or0ZHGLG3IupNVnN5Kw3EaoGC80oaeVTFZJBj
	6/4jvbGHvFT0IAqQ95uT7sJsHdNQcyrqCpEGbCND3ucdg7Svp73VRSkGrg==
X-Google-Smtp-Source: AGHT+IE3W+7ucp/82UBVPXsjQuw5LFvYIsgnE0cSH3W6VD6hw4HqpXKYpD6SZI0BdAgxbkDOTE+nfg==
X-Received: by 2002:a05:620a:2482:b0:79e:f930:535e with SMTP id af79cd13be357-79f19a71793mr1878563885a.27.1720815629677;
        Fri, 12 Jul 2024 13:20:29 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028f7csm434473585a.67.2024.07.12.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:20:28 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 5/5] ci: Add Alpine
Date: Fri, 12 Jul 2024 15:20:11 -0500
Message-ID: <20240712202011.906033-6-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712202011.906033-1-lucas.de.marchi@gmail.com>
References: <20240712202011.906033-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add setup action for Alpine and start building it. Unfortunately the
testsuite is not ready yet and fails to build like this:

	../testsuite/path.c:219:14: error: conflicting types for '__xstat64';
	have 'int(int,  const char *, struct stat64 *)'
	  219 | WRAP_VERSTAT(__x,64);
	      |              ^~~

Add everything needed on the setup action, so when the underlying issue
is fixed, the testsuite can be enabled in CI.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/actions/setup-alpine/action.yml | 22 ++++++++++++++++++++++
 .github/workflows/main.yml              | 16 +++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 .github/actions/setup-alpine/action.yml

diff --git a/.github/actions/setup-alpine/action.yml b/.github/actions/setup-alpine/action.yml
new file mode 100644
index 0000000..1c7eae9
--- /dev/null
+++ b/.github/actions/setup-alpine/action.yml
@@ -0,0 +1,22 @@
+name: 'setup Alpine'
+description: 'Setup an Alpine container for running CI'
+runs:
+  using: 'composite'
+  steps:
+    - name: Install dependencies
+      shell: sh
+      run: |
+        apk update
+        apk add \
+          autoconf \
+          automake \
+          bash \
+          build-base \
+          gtk-doc \
+          libtool \
+          linux-edge-dev \
+          openssl-dev \
+          scdoc \
+          xz-dev \
+          zlib-dev \
+          zstd-dev
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4a2fff2..b4ad5cd 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -11,7 +11,17 @@ jobs:
     runs-on: ubuntu-latest
     strategy:
       matrix:
-        container: ['ubuntu:22.04', 'ubuntu:24.04', 'archlinux:base-devel', 'fedora:latest']
+        include:
+          - container: 'ubuntu:22.04'
+            test: 'yes'
+          - container: 'ubuntu:24.04'
+            test: 'yes'
+          - container: 'archlinux:base-devel'
+            test: 'yes'
+          - container: 'fedora:latest'
+            test: 'yes'
+          - container: 'alpine:latest'
+            test: 'no'
 
     container:
       image: ${{ matrix.container }}
@@ -25,6 +35,8 @@ jobs:
         if: ${{ startsWith(matrix.container, 'archlinux') }}
       - uses: ./.github/actions/setup-fedora
         if: ${{ startsWith(matrix.container, 'fedora') }}
+      - uses: ./.github/actions/setup-alpine
+        if: ${{ startsWith(matrix.container, 'alpine') }}
 
       - name: configure
         run: |
@@ -38,6 +50,7 @@ jobs:
           make -j$(nproc)
 
       - name: test
+        if: ${{ matrix.test == 'yes' }}
         run: |
           cd build
           make KDIR=/usr/lib/modules/*/build -j$(nproc) check
@@ -48,6 +61,7 @@ jobs:
           DESTDIR=$PWD/inst make install
 
       - name: distcheck
+        if: ${{ matrix.test == 'yes' }}
         run: |
           cd build
           make KDIR=/usr/lib/modules/*/build distcheck
-- 
2.45.2

