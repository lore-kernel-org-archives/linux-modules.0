Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636918628D
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533023; cv=none; b=eLIjwKV3Z7Ce+4dfpR3axZH/dMWraolpifwBIhJU+ju286FAwJT2HrmLZBb1p/tOR8pvlWRbOsaX9kyY1DxR2rnMNf3MlSGZ0CIIPLP1OcqAisbroVYqm5tG2G8EQbJ1TYIcY5/cioz6JUguu0k4zs9a8QL1TAknPfqg33/P6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533023; c=relaxed/simple;
	bh=zeNqukykfeBzVcQJBjXGwl1ywROQhZgTZO5DLQiLwgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPIc/6RS3P+WfyMQHMhTfKbZX2f9Eaj0tpY2Xwu9Si7+EoXzabxiU6Dfh5ykFH999aBYVIbJjNr0XMjEKi2Ey73UQ/2o9aqNqJI4EvW2zRrp4cpgIz2bfzOisyl4QiSlBASvAxn5jW9nYHWu5YQh92ahGDO2ETyFeQHGH3TCLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLhJUwcw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLhJUwcw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-447fd75f9aeso4126711cf.1
        for <linux-modules@vger.kernel.org>; Tue, 09 Jul 2024 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720533020; x=1721137820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZEPDl91dKzWSTLHqn5h1YE/Ocu4Kf/XY0HCuLFY6IM=;
        b=cLhJUwcw89sn92s0yGyNorJVe93lwJnNq0FKAcMp3asmsthIxnPvI9tK8OEtyw+RXr
         bKNnUdIlCZYCkYft11wE7XCWQFUDgWiomL5Y1VHcLWyw9v2QoTqtOnu1KVPOvAfXAVj/
         sNsvKZ0xaC5H2Twu5epIWsNDihycmHDCCbH6Un2jnisTOUvLSBm50kynW31TWNnMSpKV
         8bWRcxwBq7Rx+jkfop5FsFl6X++Sb188NvUvkUnKZXWCrWeNescUTTK0Tp1KyjUrWnRx
         5DSfTYCq9cUA15SpxHQOsDLZPv2ML9sYtnexlcPsPXzPK0hO7QFxdV3S8yFcIjZYs+KC
         m2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533020; x=1721137820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZEPDl91dKzWSTLHqn5h1YE/Ocu4Kf/XY0HCuLFY6IM=;
        b=HMSC3peLU7UQ9ibi5sSCBS0fcYwBLK6ZrxlqL/cMVjQu4XBx91vhJ8p/1GE0d39bdW
         5pfsHP3PxDH5i53LpBTLbVj1WV3uO7nmoQaA8AIMkmW3DB3wLqVFtYKheX9/k7ifVeGU
         1Z1WVCADc2b4OpGBQ7uBRpnUzhoMUSW5L9rhcEqrwdN/AFKeudcqESCA5BSZJhISdmRC
         UCOJSUhEMJPsf8LXIFQIyt8/mEoRrwZDiijhxM6XdiNMCTeWgoKhaEaI1PxjBE8CzMkv
         QcG2RPddpiMi3zlDAk3/JAM42OqZgV6dCwDoW1w71s6kd07YGMdzAKSLxyUkk45vmUId
         E/Dg==
X-Gm-Message-State: AOJu0YzZCe99laQ3bZkFpOZBDsIkAqREsjPJZDwcAu1/SVSCbci53G8D
	3T03pd7TZ2b9fbEipKd2Mbep+HXt1xum1eU8+QqjbBde3cpOdCpo+Qb8JA==
X-Google-Smtp-Source: AGHT+IGPu9cemw2jg9nWjtljioavWfnmyAlwCDmP6xWicPYhJOP/97BNigcL0M6bMYHH3IJae+795Q==
X-Received: by 2002:ac8:5ac6:0:b0:447:e808:ab24 with SMTP id d75a77b69052e-447fa908876mr25135701cf.50.1720533019904;
        Tue, 09 Jul 2024 06:50:19 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b4e536sm10604831cf.39.2024.07.09.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:50:18 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH v2 1/1] ci: Add github workflow
Date: Tue,  9 Jul 2024 08:50:07 -0500
Message-ID: <20240709135007.104325-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709135007.104325-1-lucas.de.marchi@gmail.com>
References: <20240709135007.104325-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a minimal github workflow to test kmod. This can be incremented in
future to test more distros, compilers and libc.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .github/workflows/main.yml | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 .github/workflows/main.yml

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
new file mode 100644
index 0000000..79eff14
--- /dev/null
+++ b/.github/workflows/main.yml
@@ -0,0 +1,56 @@
+name: Build and Test
+
+on:
+  push:
+    branches: [master, ci-test]
+  pull_request:
+    branches: [master]
+
+jobs:
+  build:
+    runs-on: ubuntu-latest
+    steps:
+      - uses: actions/checkout@v4
+
+      - name: install dependencies
+        run: |
+          sudo apt-get update
+          sudo apt-get install --yes \
+            build-essential \
+            autoconf \
+            automake \
+            gtk-doc-tools \
+            libssl-dev \
+            liblzma-dev \
+            libssl-dev \
+            libtool \
+            libzstd-dev \
+            linux-headers-generic \
+            scdoc \
+            zstd \
+
+      - name: configure
+        run: |
+          mkdir build
+          cd build
+          ../autogen.sh c
+
+      - name: build
+        run: |
+          cd build
+          make -j$(nproc)
+
+      - name: test
+        run: |
+          cd build
+          make -j$(nproc) check
+
+      - name: install
+        run: |
+          cd build
+          DESTDIR=$PWD/inst make install
+
+      - name: distcheck
+        run: |
+          cd build
+          make distcheck
-- 
2.45.2

