Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788729CEA
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 04:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500495; cv=none; b=stRj3FQGFJUjxM4r44EL7AXoM870abnrvkE702E5T0UoMItVJ+NBdTbh5itCPNFV1LEeZEydxfBJw/YpMODAScqmOt9fUC/lxhDtyVUm39ZHrpPaAVv8ZV0fyZcvrfpTSeB31BCgTz+yQGfRu1v8eiBKXL+ievTvtq5aBSAfxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500495; c=relaxed/simple;
	bh=z9w+UWg8IbZRKBf1VqqsR0EPRlCBiZbqfT2bFaG5SAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gi3ntIMdCfdWLppLrP8oTMyOqArgkGJmyAWhOJkUyANVZZXCcRfVcZKPk+/azw8mpmxr4xHlbGNF3p5u/S1TpP8VQRNVqRWzhejkWEoYdDxCptdhf/eITjIlNT7gDPTWg7kqFpMDYDZLTaR8eBGZMWiA21UuNIxYPTQyD81ruvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQphsKPA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQphsKPA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef8fe0e90so239754185a.3
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720500492; x=1721105292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXL4CocAqV7ghKWQu0gPH2qFwJLiOfrJfPq6eZQc61A=;
        b=bQphsKPA5HZCgGTvhG3coaTz7tI4LeQzDHlcMOfrRN4zq2pbVkKrOFfue352+67U3d
         N+ex8dIbh6+JKagCbrgNvGDbhxx+jZL9mAab7uLorGZFyU+Exnvc6Q9UCY1sQKf+Deso
         m+X6MDdHNfMK3Z/bOhm8NGPpyF8FGnMgn0+wXoC/IS6MIpC4xrduBMAjof418FdlRSoV
         tcnw6BjvN/U7Ph2Oe4OSj7hipSkmtLt+s9r1i2Z74X0jv4w/ptiVnPWS3FILKYaBS58n
         15/0mPgmAZdiIMSkh2UEZvH+KEnUXS57EwOyPlXGMCttA7lpewLSTwNq28tCBpitSG+V
         6QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720500492; x=1721105292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXL4CocAqV7ghKWQu0gPH2qFwJLiOfrJfPq6eZQc61A=;
        b=dGkzkXpGAaK3mwv9QelPPTN/cbH+8/nVAx91tNj/M9UpyrqgnqSx6IHb9x3VRlp2gP
         kF9F3VtzoD5CaQoN+YM409eEiXb3hsfe9YN6DBF5Rb0MLMkkjwWx64nRAa9jCqzZ42ag
         VApn63Ze/8JBeNcaUOcagPQmhk5F6jrcuc7+jMxR5Wfy5spkcPSNiWGU6ogkeOrkIN4z
         LTB2t4HvXFqQBHClEWVtF2KYFdRc9ykEJHvUPWcj9wmFMe+VnYM2Xn1Et4LUAoMLE6ds
         Cgl3oanSMuJI7wmW4fQOIHnKZdfQ9vvvjxuTYHST97cwquM+olgbY+n2c3L/dW3Gs8Ds
         ffDg==
X-Gm-Message-State: AOJu0YyYtfzK8ww8Vn+eN/ybdlym1fQjqFo7r6g03JHsjqpi2WFjiSd1
	UnwTIPXM3mmGpWxr1SenpDFH+TwdIu8NYSZA+hOpWyMQpqnVvdVtelGikA==
X-Google-Smtp-Source: AGHT+IECXYYq25lKLiUtz5XEXFM5zBPENkQxp6fy1Je0KzvbwyDi/2RfCDutzMi71fvUSIbnyEg14g==
X-Received: by 2002:a05:620a:13d9:b0:79c:1345:a7fe with SMTP id af79cd13be357-79f19a1f377mr154096685a.24.1720500491884;
        Mon, 08 Jul 2024 21:48:11 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm58639985a.59.2024.07.08.21.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 21:48:10 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 1/3] ci: Add github workflow
Date: Mon,  8 Jul 2024 23:47:56 -0500
Message-ID: <20240709044758.67725-2-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
References: <20240709044758.67725-1-lucas.de.marchi@gmail.com>
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
 .github/workflows/main.yml | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 .github/workflows/main.yml

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
new file mode 100644
index 0000000..f366846
--- /dev/null
+++ b/.github/workflows/main.yml
@@ -0,0 +1,49 @@
+name: Build and Test
+
+on:
+  push:
+    branches: [ci-test]
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
-- 
2.45.2

