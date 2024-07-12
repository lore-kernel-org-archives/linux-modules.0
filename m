Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F53B1BC
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815628; cv=none; b=cxnxK19P5nIrrl1XgvQNzUl1bItlB8o0mQpGi1nW/Iz5mFyyCyE6aqbx/TCM1VQOPf1Rd1llLQXTaK3IVFY9P+x5RG25V9e0ObqlPt93UR7vLI7oezwA6hzy+Nyf4cFIUIGtEHiiHOvn19OkTDWlkYxTelxbt4CVLcVCnC/B4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815628; c=relaxed/simple;
	bh=yzzf76ufAJH4uyQbCgCcTB6l9lX9QcoW9B34b8dLxe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgcmbj7JlXR1okt/10iGlP+tEIYeRgiQbPkAYaTUmOIUNIPjxcnnkLbxw7KHRkxh/lSSpmwUjYQxCQeXw8Y6FCq5nRi1JXwIuImC5dZC314YkagVqEGkjfaYTBLY4H42iORI5S0HrmH3/5zODgmmAjfDjM2+7hNLiZ7xDWsE6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLxXzDCT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLxXzDCT"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79f16c85da0so164779185a.2
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815624; x=1721420424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcJzEIa4T0z9J8ekkCACO9PePAc4lrwxAI6AoQDPAjg=;
        b=NLxXzDCT9P9k8deme/1T9KkqlXerb+TpR8E153dfvPRkUCXPoxKP8GUTRjjIX/R+cR
         BrBoUmgNIS1k/iwA7F1HoHkr1bytVLurbSk85Y55vsheqCgYSJNNkkDxaE/m781gqov6
         PUfsC1rTPveAjf/v4ittgA6M8kATz64mJA3uFmzOx7lzyya9XAnIo+iuADeAK0YpsHq5
         pJtO5dM5SRIIP8oAqyJP+F8OqxwFW4aaylABacmmtRc19dGiulJ5XkXWnX2e4qFY4xho
         PDnIt/WCUVmhtld6v3Q7dIVdO0mcTMWP2PMSNMLI4qydRZoeZVcTtKp1c+BA/01NU43W
         GZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815624; x=1721420424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcJzEIa4T0z9J8ekkCACO9PePAc4lrwxAI6AoQDPAjg=;
        b=HsKdK3WdM23tAgPDe6svox6rc/XGdtTcf8C9xGupZXXZGrCGLNDQc8KT1d4HQKbBCR
         +jxt4dG3I4+fpmJhVJXJrfG4g405oKjMCB0OfMIq15XBo6I44FxFPF2umLh6imp4fkH+
         prZWvmWdhb3GwEsmG0NrG8TQBVPT5AbsenoS2IkT+AW2wyuGKzHJY0jKG2KF335voUPn
         CFrlq1ETkZzJJe7XxXuGBgtGrTBoCM4zgfYippN9RDpbBLUHu3akMg0gnQI6UzfWvHpC
         fom1RRySw7eiSKlPUC1SE7U6svUNLdlzcAqT0jtPCYsasGXdlcs6AkNFnMa1kAJV/png
         26Mw==
X-Gm-Message-State: AOJu0YyS5FgLA+F0W0CvBGjuRpVYvUSTYjkN5Ilh5EPWzvDIrA7srhQz
	JkWz5RgNbp7d7ZZr/rO6y/C71yguNKon+z6LRxG4z4u6Cl3nIExVgQgZng==
X-Google-Smtp-Source: AGHT+IEGOH6ZqKsyXVOK8DXpnLHQWQBBwfAPE6gNbBSluR6RaZ0MIgGvoVWhWtofTXy4B3k2iWcRnA==
X-Received: by 2002:a37:f50d:0:b0:79f:16ec:92d with SMTP id af79cd13be357-79f19a6f219mr1455060085a.27.1720815624192;
        Fri, 12 Jul 2024 13:20:24 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028f7csm434473585a.67.2024.07.12.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:20:22 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/5] ci: Use a container and expand versions
Date: Fri, 12 Jul 2024 15:20:08 -0500
Message-ID: <20240712202011.906033-3-lucas.de.marchi@gmail.com>
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

Use containers to build/test so it's not restricted to the OS versions
supported by Github runners. A few changes are needed to the workflow to
support using containers:

	1) No need for sudo, so remove it
	2) Explicitly install missing zlib
	3) Explicitly pass KDIR= while building kernel modules, since it
	   won't match `uname -r`. This assumes the container has just
	   one kernel installed and so /usr/lib/modules/*/build can be
	   used as the single symlink to the kernel headers. This should
	   be common to other distros to be added, too.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/actions/setup-ubuntu/action.yml |  5 +++--
 .github/workflows/main.yml              | 11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/.github/actions/setup-ubuntu/action.yml b/.github/actions/setup-ubuntu/action.yml
index 554d261..f60cb1d 100644
--- a/.github/actions/setup-ubuntu/action.yml
+++ b/.github/actions/setup-ubuntu/action.yml
@@ -6,8 +6,8 @@ runs:
     - name: Install dependencies
       shell: bash
       run: |
-        sudo apt-get update
-        sudo apt-get install --yes \
+        apt-get update
+        apt-get install --yes \
           build-essential \
           autoconf \
           automake \
@@ -19,4 +19,5 @@ runs:
           libzstd-dev \
           linux-headers-generic \
           scdoc \
+          zlib1g-dev \
           zstd
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fa9c9b9..a9ad289 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -9,6 +9,13 @@ on:
 jobs:
   build:
     runs-on: ubuntu-latest
+    strategy:
+      matrix:
+        container: ['ubuntu:22.04', 'ubuntu:24.04']
+
+    container:
+      image: ${{ matrix.container }}
+
     steps:
       - uses: actions/checkout@v4
       - uses: ./.github/actions/setup-ubuntu
@@ -27,7 +34,7 @@ jobs:
       - name: test
         run: |
           cd build
-          make -j$(nproc) check
+          make KDIR=/usr/lib/modules/*/build -j$(nproc) check
 
       - name: install
         run: |
@@ -37,4 +44,4 @@ jobs:
       - name: distcheck
         run: |
           cd build
-          make distcheck
+          make KDIR=/usr/lib/modules/*/build distcheck
-- 
2.45.2

