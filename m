Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57743CF73
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815629; cv=none; b=hGZPBVHUgKCEC2iWz5Ms5nFNxRMUYqv6MwjVDDGrU/lUDLz57AwBEq8fMHUVopxld9FaQIhSiY5Su/J6Ro78J+SLOQ25fpleqlW8mMQbxW18onKyOUuQq5m7C9t1B2FJul0j9m2aLdXKEzsR2ZXJORKBUpyAD3oipAkyrU0dcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815629; c=relaxed/simple;
	bh=L+XSuT4vneeF8lBHWGGfAoBVlCO0B3B+XkOBIYYBiWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK/KAa9rp/IponKhy9AHfGsp0mtyeXYyiWxJa3RW0P3KvpAnBuDRixPgKCHBMysliP1C6ZDdSHRVo4JMrg0hs8UJTPmaY5CiembqKEnCmsgZ3JR3BDumMvNftzWHMdl5GjNftUjiHtzAH9UQchHRjDfJwUFmswSrk/GXnNpR9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnaUYLvz; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnaUYLvz"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef7ecc7d4so157564785a.0
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815626; x=1721420426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg07oqyKLj2o7G9r/7jnxWukDrSmFxz1BaFJY/9vu6Q=;
        b=HnaUYLvzHh/KJ16K/qIqGPbCZ5/5za7/i0s51z7TzQ7QnWZddU3R01DW30FDOD88T+
         z4uimOp+Grlv5cK3GoK0QawXsjaEht0gZ1yUqOkqPJ14nHRolwHY4DhaughvbuLPWUmP
         sfm1oU8flunui1j9UuMMTb0Wp/UEjZmKvTbXDxVROjP0AMST+MSLqXKyVxop5fk70koQ
         lMQ96swQquzxn8+fTlENwCVUpR3G9Qw/BWla83wQaG9W2sUhOzYIcYrFbs070D8F+Ut6
         /9HUbIKQJOfCsFUoVkLmdXP5/feB8D7spffmCSuTzKmF9uQS77hmQ2OVssV3GMTjKNWl
         EQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815626; x=1721420426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg07oqyKLj2o7G9r/7jnxWukDrSmFxz1BaFJY/9vu6Q=;
        b=tZPHTgs4ofmDsjpnjDclnSjdY6RwNaUZXXDoIBwgkWkILMzSTnEkBbFxHPsOiNYMJe
         hrz2wbfrulv8W4TjiDIlqBWiJO1by+O2KXbGe49i77wiPxeSpEoj2FbW5W3NB2JTeLK3
         sdxptOuaPzdB00X1LdCfQ2fNUiE8QiQsH3WcgEnId7+JbB9zWQQBAd6DUis1ZO4WsZMm
         NnqL6KbTQsJMFAI3DTMYJp0i8/Io0gaHyPt79sslqK74majkjCXViA+qNKMyxjG4Tut/
         imI6HBUpez7biW6D7IVEIw4kMxIBFmX9jgUDXJjD5sYhYY8YYiVmJPwExNa1bEjawE78
         gfpQ==
X-Gm-Message-State: AOJu0YyPMQeUtJc9lM/C1DBtDAE9ows52Dn6KlG9gOuJ3uA7y/0p7zrE
	xWeM+WgsLXKCaJsTAS2eZNiufFYeNIHbSQuCHBsgkindTGaUSAUxjHuQsw==
X-Google-Smtp-Source: AGHT+IEInglDZE++zREXnxhLC8aZ/Qd4dLNNrqmZkkQf5GjI57Z0LL0EXoK7VIna+Up7uPc4elEspw==
X-Received: by 2002:a05:620a:5d:b0:79d:7a40:1bde with SMTP id af79cd13be357-79f19a50927mr1379189685a.45.1720815625948;
        Fri, 12 Jul 2024 13:20:25 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028f7csm434473585a.67.2024.07.12.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:20:24 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 3/5] ci: Add Archlinux
Date: Fri, 12 Jul 2024 15:20:09 -0500
Message-ID: <20240712202011.906033-4-lucas.de.marchi@gmail.com>
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

Add an action to setup Archlinux and use it for the initial setup.
The rest of the workflow can stay the same.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/actions/setup-archlinux/action.yml | 16 ++++++++++++++++
 .github/workflows/main.yml                 |  6 +++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 .github/actions/setup-archlinux/action.yml

diff --git a/.github/actions/setup-archlinux/action.yml b/.github/actions/setup-archlinux/action.yml
new file mode 100644
index 0000000..9b22a9a
--- /dev/null
+++ b/.github/actions/setup-archlinux/action.yml
@@ -0,0 +1,16 @@
+name: 'setup Archlinux'
+description: 'Setup an Archlinux container for running CI'
+runs:
+  using: 'composite'
+  steps:
+    - name: Install dependencies
+      shell: bash
+      run: |
+        rm -rf /etc/pacman.d/gnupg
+        pacman-key --init
+        pacman-key --populate
+        pacman --noconfirm -Sy archlinux-keyring
+        pacman --noconfirm -Su \
+          linux-headers \
+          scdoc \
+          gtk-doc
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index a9ad289..3f8eaa6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -11,14 +11,18 @@ jobs:
     runs-on: ubuntu-latest
     strategy:
       matrix:
-        container: ['ubuntu:22.04', 'ubuntu:24.04']
+        container: ['ubuntu:22.04', 'ubuntu:24.04', 'archlinux:base-devel']
 
     container:
       image: ${{ matrix.container }}
 
     steps:
       - uses: actions/checkout@v4
+
       - uses: ./.github/actions/setup-ubuntu
+        if: ${{ startsWith(matrix.container, 'ubuntu') }}
+      - uses: ./.github/actions/setup-archlinux
+        if: ${{ startsWith(matrix.container, 'archlinux') }}
 
       - name: configure
         run: |
-- 
2.45.2

