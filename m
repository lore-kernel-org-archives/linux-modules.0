Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8FD3CF73
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815631; cv=none; b=U0Z9ikv02LAcj8WtOywFipGl+Q9sR9DOJeoQfkn688FoNbvYOsPLlReWFl1RBaE8Tdm6LWr1GIavBe3cNfW6eJBbdkkvXM47Zdi71jI/1fsOsMMy0Jf0hQAQk10RfiYggAv4CKKubHmr252QUYNLpdcvzaGJVBgB5W3cXNQP24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815631; c=relaxed/simple;
	bh=/PScWKQ6JRaowVmLZ34PxYDPysAZLFtS/ZszCOYeC+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWI374Z0XH7qLj/BLCJwb18eMtihFOggo/bCjuL1i5XMSOWkJh5V2L8a4IQJDkXWZ4Haan+yZJ69/wYvApJBLcsqEDLEmM/Zev9ntCwMW7QMR6mnSJADSL9D0mKPLDL0346M4+KwclC6G+QTtJLTD4B5n01tkHQJmFfHb5zP1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqpELh4n; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqpELh4n"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f17d6be17so162796785a.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815628; x=1721420428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3ZloF0N7zIHm56oe3UDqWfxOCcu4B5Cilc20tAHFiw=;
        b=fqpELh4nPAqIo0rSqsXaThkUm9pFm7dy1Xwng93qGBconPuAbdoDsak/5qM6ZpGIDu
         WB57JJNtTWKaC9B7AiccL17cqhW7h83hZSVNMluVt45NDjmc4mWAbBy3Pz0lhMH2cF9c
         YTf3hNYqDW734q/DSFSjJJuMpM9uHVyJa8Ts6PeiN7d8/ihmvCwng6cznNcH1Mt5Y13C
         aHpzfCgxwXrkitkW6+lI+jU2GYotlh72bWOBSjWrjFGhD63ha1cdIa0Wk8xEvKhnyozY
         2JJQ8Kz3yW6XVh3xqzZc0GRPz1QAsCvZd8i+laAVVIXIL+m5KSzmVtdSwIDJrBumvEJF
         axaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815628; x=1721420428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3ZloF0N7zIHm56oe3UDqWfxOCcu4B5Cilc20tAHFiw=;
        b=IwqKagRLR1uYZACJrxXKvVV6EBK2MG7g1hzQCMfK+kHY7HhZ1W6TMPEMfKkvjws3Jf
         MtMu5qJZ44rHYDUagVDSkMrJfurv36fFB6GiNzdYZd+/LWgUadKrlwzGbLK4qnWiEyfS
         m0UuTyXkC6BPDtsWXOdRHZOlPM2eU6vtn18l4oM/AFvPHIX9QGMR78YAkHnE3eC4G/yH
         KDDnKOWsbOGQrnE7J7Zn6sFyF+wE8b8Yk8DxqACyOBDwEuqizJSy0pA3KkgZttOXIPm6
         oZbVj3oPEPpM8ayqMA0wJKKbiIVaE1YT2siPkTBb7DoatqIrEniNDf+h8VDBXr9BKAfg
         CreA==
X-Gm-Message-State: AOJu0YzlI2tl+TqUxNRrBsmYXaSkMCUTgYAFVeY1FIJP69NFYmTwOmWX
	B9XQc6VseYRU/nDPRJy9dXParpfqbrRdqhESMde6TpkPpAGzMPIMyX2GAA==
X-Google-Smtp-Source: AGHT+IH64Bho6IBwjAPsOkOCwKoDKOESlZD2BQAPya3yhRTMLaH5nnVjSSRCs++36a2K/sIz6QglAA==
X-Received: by 2002:a05:620a:45a9:b0:79d:6cb6:a7b8 with SMTP id af79cd13be357-79f19a51d4bmr1835832485a.1.1720815627994;
        Fri, 12 Jul 2024 13:20:27 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028f7csm434473585a.67.2024.07.12.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:20:26 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 4/5] ci: Add Fedora
Date: Fri, 12 Jul 2024 15:20:10 -0500
Message-ID: <20240712202011.906033-5-lucas.de.marchi@gmail.com>
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

Add an action to setup latest Fedora and use it for the initial setup.
Add hack on /usr/lib/modules so /usr/lib/modules/*/build can still be
used in the rest of the workflow as the KDIR.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/actions/setup-fedora/action.yml | 27 +++++++++++++++++++++++++
 .github/workflows/main.yml              |  4 +++-
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 .github/actions/setup-fedora/action.yml

diff --git a/.github/actions/setup-fedora/action.yml b/.github/actions/setup-fedora/action.yml
new file mode 100644
index 0000000..a2612e4
--- /dev/null
+++ b/.github/actions/setup-fedora/action.yml
@@ -0,0 +1,27 @@
+name: 'setup Fedora'
+description: 'Setup a Fedora container for running CI'
+runs:
+  using: 'composite'
+  steps:
+    - name: Install dependencies
+      shell: bash
+      run: |
+        dnf update -y
+        dnf install -y \
+          autoconf \
+          automake \
+          make \
+          gcc \
+          kernel-devel \
+          zlib-devel \
+          xz-devel \
+          libzstd-devel \
+          openssl-devel \
+          gtk-doc \
+          libtool \
+          scdoc
+        # CI builds with KDIR pointing to /usr/lib/modules/*/build
+        # so just a foo/build pointing to the right place, assuming
+        # just one kernel installed
+        mkdir -p /usr/lib/modules/foo/
+        ln -s /usr/src/kernels/* /usr/lib/modules/foo/build
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3f8eaa6..4a2fff2 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -11,7 +11,7 @@ jobs:
     runs-on: ubuntu-latest
     strategy:
       matrix:
-        container: ['ubuntu:22.04', 'ubuntu:24.04', 'archlinux:base-devel']
+        container: ['ubuntu:22.04', 'ubuntu:24.04', 'archlinux:base-devel', 'fedora:latest']
 
     container:
       image: ${{ matrix.container }}
@@ -23,6 +23,8 @@ jobs:
         if: ${{ startsWith(matrix.container, 'ubuntu') }}
       - uses: ./.github/actions/setup-archlinux
         if: ${{ startsWith(matrix.container, 'archlinux') }}
+      - uses: ./.github/actions/setup-fedora
+        if: ${{ startsWith(matrix.container, 'fedora') }}
 
       - name: configure
         run: |
-- 
2.45.2

