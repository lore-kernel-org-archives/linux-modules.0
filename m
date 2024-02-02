Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2285941
	for <linux-modules@vger.kernel.org>; Fri,  2 Feb 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900917; cv=none; b=kSDEtAV8ZSZLya/SIsrmiUa+gWxvmY6X0cJ03cJMy/oeY7Jm7PagoERdROKs83FNsxTRrxNBzVA8wnKgCvKRs3OFhIEwnjE0ugkxbqdZGUqBRXF5gNR5R0XNhBz1P6xHFWp39MkoiaEjxlKCbhSxNfO9yXc2v+EJRCkeZAdnbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900917; c=relaxed/simple;
	bh=bbti+o6kZ2muF89YanVt1GPloBYjBhJXmQD7LNtnvlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar5d+DaQ6oVv+rR6/MPm0pdZdvcforkngp1vxKXR3lLZxHIb6TW3f60Hfcl9nzxNnOxsAAAUKm/F5xiG13tl7okC8V68d/viSLkIaVhDmkHAasd15cmFIfm71v7bzm4AzeU2HMS39taGEDFAoO5ohBWA9o/7ecnoe6ch4mMdXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwJO2S7a; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwJO2S7a"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783def87c8cso148799685a.0
        for <linux-modules@vger.kernel.org>; Fri, 02 Feb 2024 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900914; x=1707505714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlJmBRAT7Mbuj4FgzxCq8g/MThEWXclEcWa2a+K95CE=;
        b=gwJO2S7abF4GwwnQwhb+AEOI5LdMgZzGKscBSilVi1rRD2s647y/Ri8eRVuG6p3rsX
         0JozFB3AxR0sPgunZmO1pYOuFqCHQ28TGq4Ime04z2X2SsyeCi7FN2y9/DV36ns+mkWZ
         VHyoULRDcPUVk02490k629FMARdcFzujv6+9ge0cUIkyt4BDGxDhhmOTbZXon8g1argp
         Hskh694/YEuQXsAPuhBqnXANHrACnvvlqsJJhfwWHfL0WcRIfAZE7t+Y0+aW4LJVtAfz
         uACKvRaxyI3kPGk+xHvyYtnN8B8sVC8avURAEt2kxlMc62g81r5D5GIK2jRDDv4klfMO
         +hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900914; x=1707505714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlJmBRAT7Mbuj4FgzxCq8g/MThEWXclEcWa2a+K95CE=;
        b=UGp6MjbE1KRxril8SsCxG+K4gg/5q3+TPSEgn/FRoqhxE7Ow99vPwZjePQatQNlTjK
         Ofy63M4dVaFBlOZnpjMPfg134P4LxO+q7oz/fYb9AbUdORUjbtm5Ws/qBtmCSCd3UejG
         8s4bdKHsC6fAuBmimOzpOKNN7uBgOXKsSI07zgVBwJ1O5Pqk1YJ52kvGdzekAR2XAf+y
         gfweKNuKfYEPBiDShOwXlzDQk53nJD18kjLeI9MR7BUJ9hS6arGEitNi2hMs1KzyKOhz
         oLuRM7J+VXsRfghvPfB+yBGT6xTZmmEFId4fgatGUgy9AGbnwKgxvWSzkbcrkrOs+ntK
         aLxA==
X-Gm-Message-State: AOJu0YzUaq5wZXH8xeKnFKn6EvvA+7sWPvQzU3xvrxvqg28E90STAEEe
	X2laAgFn9YFKRKRWTMQhNCcU0Y1Bj2gwK8zBHbKw68us4Nz8ZO3uobjDUNce
X-Google-Smtp-Source: AGHT+IGgUMYayb1fdK0JNboz33fiGQlsz+dJg2pyOB2+tz2qQ7qP9PkVGCBhI4JeI+EdATg0IU11Wg==
X-Received: by 2002:a05:620a:55aa:b0:785:38e3:ae78 with SMTP id vr10-20020a05620a55aa00b0078538e3ae78mr6499556qkn.58.1706900914008;
        Fri, 02 Feb 2024 11:08:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWu3SrCUV1VWBpG60dSmHn1ap5z8IQb1lJzcK8HLkp6oA5rWBpuyHDL0z7K/NJH1ecg3lCxXpvPeVi+22oc+AJ+v9grs/hp7ZM=
Received: from ldmartin-desk2.lan ([192.55.54.51])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a15a400b0078408de98e6sm903011qkk.72.2024.02.02.11.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:08:33 -0800 (PST)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH 2/4] ci: drop travis config
Date: Fri,  2 Feb 2024 13:08:21 -0600
Message-ID: <20240202190823.418148-3-lucas.de.marchi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
References: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are not using travis anymore for CI. Drop its configuration.

Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>
---
 .travis.yml | 32 --------------------------------
 1 file changed, 32 deletions(-)
 delete mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
deleted file mode 100644
index 64dd6cd..0000000
--- a/.travis.yml
+++ /dev/null
@@ -1,32 +0,0 @@
-language: c
-dist: focal
-
-matrix:
-  include:
-    - compiler: gcc
-      env: CC=gcc
-    - compiler: clang
-      env: CC=clang
-
-before_install:
-  - sudo apt-get update -qq
-  - sudo apt-get install -qq libzstd-dev zstd
-  - sudo apt-get install -qq liblzma-dev
-  - sudo apt-get install -qq zlib1g-dev
-  - sudo apt-get install -qq xsltproc docbook-xsl
-  - sudo apt-get install -qq cython
-  - sudo apt-get install -qq linux-headers-generic
-
-before_script:
-  - export KDIR="$(find  /lib/modules/* -maxdepth  1 -name build | sort -n --reverse | head -1)"
-
-script:
-  - ./autogen.sh c --without-openssl && make -j
-  - make -j check
-
-notifications:
-  irc:
-    channels:
-      - "irc.freenode.org#kmod"
-    template:
-      - "%{commit}: %{author} - %{message}"
-- 
2.43.0

