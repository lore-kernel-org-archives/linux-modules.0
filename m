Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69573B1BC
	for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815625; cv=none; b=iDSE4KplDRN0yH8n10QxBfUAwNJgw+qlg4uYrhnuuuI2KeZ23LTvjin5Mg7bBSeqyW2aIU7QBow9LSRtueDixiQf0ZaWMw1b/xg0fmx6aqiK3fUwfsjtLOKTEWMBHAJ+NFhf/hmMm7QM20EwYHS93TQsYP6OjmfC3CaXSiErFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815625; c=relaxed/simple;
	bh=0T48t6sfd0VkfPNeM5QbBtt+KDwq2Fa234DzncRZiwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtAimIIAsk+wXOg6Up4P1g74zhtyoB2QAfu59zB4SUc62FJqJzg4OibMluzqNZ1KJG05AtN+riudzCHhVNUxOyvd0BhzpqaivnFjDXcRR6vS1z71w0SeOcRPKQ2Rm17u4vVoBYRoJl7xivzoH0rHUPfEb/wXPAl1sZh1Jn0EmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ593Ga/; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ593Ga/"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d9c487b2b5so1452681b6e.3
        for <linux-modules@vger.kernel.org>; Fri, 12 Jul 2024 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720815622; x=1721420422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4j1j/WYJEzLsa6TiS2XDZ2PsMffRwqUeBPYw60ayeY=;
        b=RQ593Ga/If3a7EeNIU1zXFdoSFuoSdMCAWaJJo4nUtDN20NNNnSfaeRaNbhv343u2V
         F5LvviHdIyq8VV/i6idQuK0/JFx4UZh+9oAaqgTkv4eO0VAcv8/yMSDXDj9znXnSFhsh
         0JmxeRsKWhyxLGkVddki9HWfpoKeT061nNiKRajdoCHHOqn0ue5b2JIot7BbGlPTBeKR
         wYIAAyRSiZsLlG6+wUbojgAaIf++sl1ShIyj1l9PiHmaBG7HZFCGyW3Uv57XILDgJCbI
         1/njza7vrycXQ1k2WMCuSKsgnaI8n73cl25tmmB1Z2GBtL1+4+w0O9uSp2Kp/kfd7/Dg
         aanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720815622; x=1721420422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4j1j/WYJEzLsa6TiS2XDZ2PsMffRwqUeBPYw60ayeY=;
        b=f/UfVDFHgQ2yYnzOYA/xeRdBuskrkyTu4YVt0zHjvksNDvicIvFJ6IH69tTqF9rVOY
         7fT64B8Hz7MG/wZNgZ7vQOOYHNgto67JIunPFnO6cRb4wLsnE1DqwOEgZ9936bZF9Bmd
         PyKuvQXe+9ZVyVo66q7KkZGRFgF+J5b9hBTbNIW8dpE5ETt+AMCZwb2qeSRiPGvqATS+
         34Ujv3NypgTpsv3V7QfroHno+o2zDnLsc98EwDY417z4EuZysxMkRpExT/eBKd0yvEiv
         UAiWdth0bAK6Oc5i2KYho0wvemu4uun498JSECnDBFUjudYhCw4BgD5WOG9W4plmfSZZ
         oI3A==
X-Gm-Message-State: AOJu0YxcowcLTizYhkMpVOqAZnjLcBj+F8GTJ3eizSPY6x/pscbip3kC
	6uTRRPc9HgP8H/ngRI3pMIlxGig3VuzFlmY5LZMKB95jkKG2nXiulmBapw==
X-Google-Smtp-Source: AGHT+IFyy9vRAoZ984KEOoL/fGVyZODpjqtf3MtjwWUjaRHD8q7h6c8OXb/qc5GFpUxEbFjHSyiATg==
X-Received: by 2002:a54:4586:0:b0:3da:82e9:ea9b with SMTP id 5614622812f47-3da82e9edbemr7454333b6e.43.1720815622045;
        Fri, 12 Jul 2024 13:20:22 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028f7csm434473585a.67.2024.07.12.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:20:20 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/5] ci: Replace package installation with local action
Date: Fri, 12 Jul 2024 15:20:07 -0500
Message-ID: <20240712202011.906033-2-lucas.de.marchi@gmail.com>
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

Separate the package installation step with a local action so
it's easier to support more versions and distros.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/actions/setup-ubuntu/action.yml | 22 ++++++++++++++++++++++
 .github/workflows/main.yml              | 18 +-----------------
 2 files changed, 23 insertions(+), 17 deletions(-)
 create mode 100644 .github/actions/setup-ubuntu/action.yml

diff --git a/.github/actions/setup-ubuntu/action.yml b/.github/actions/setup-ubuntu/action.yml
new file mode 100644
index 0000000..554d261
--- /dev/null
+++ b/.github/actions/setup-ubuntu/action.yml
@@ -0,0 +1,22 @@
+name: 'setup Ubuntu'
+description: 'Setup an Ubuntu container for running CI'
+runs:
+  using: 'composite'
+  steps:
+    - name: Install dependencies
+      shell: bash
+      run: |
+        sudo apt-get update
+        sudo apt-get install --yes \
+          build-essential \
+          autoconf \
+          automake \
+          gtk-doc-tools \
+          libssl-dev \
+          liblzma-dev \
+          libssl-dev \
+          libtool \
+          libzstd-dev \
+          linux-headers-generic \
+          scdoc \
+          zstd
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 79eff14..fa9c9b9 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -11,23 +11,7 @@ jobs:
     runs-on: ubuntu-latest
     steps:
       - uses: actions/checkout@v4
-
-      - name: install dependencies
-        run: |
-          sudo apt-get update
-          sudo apt-get install --yes \
-            build-essential \
-            autoconf \
-            automake \
-            gtk-doc-tools \
-            libssl-dev \
-            liblzma-dev \
-            libssl-dev \
-            libtool \
-            libzstd-dev \
-            linux-headers-generic \
-            scdoc \
-            zstd \
+      - uses: ./.github/actions/setup-ubuntu
 
       - name: configure
         run: |
-- 
2.45.2

