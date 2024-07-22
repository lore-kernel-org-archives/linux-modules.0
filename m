Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741FE12B63
	for <linux-modules@vger.kernel.org>; Mon, 22 Jul 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639228; cv=none; b=Dp1OwQj/uwQpakt9Mn7Xhwr8d/twQueVDp8IHX2F4V8LETXX+X/3h9b0U1u6Gjc7h7QhtkXupUT/r3k0lkGzv0M3r7KiYC5C4KCDF47TH2bTXmeovdzGJNQE67s7XyYuCxOqReTC4a/PqblAqnKgWLxRFt6SZJ/Ungnw+BLe+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639228; c=relaxed/simple;
	bh=MlDwDQRKF9twVEG79iWcfbddm9tGGXPNnP1U28eThpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqHoyh8LYDz1YBbJPmPer0bvYCmtZazjYp8Vw3qDJkX8J50l+QMwpP9/dvVnbX8obgTYKIDYINR1EJcCjmsyfkif6rzk789L5LHaHhc8ok3ij1Ru01tMoY5tjuxUAS+UFZKVXTaF7I+7lTjdHI0K+x/liTASuC1LRkqbvlNQcBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dPDLY4QL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dPDLY4QL"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eefeab807dso49887821fa.3
        for <linux-modules@vger.kernel.org>; Mon, 22 Jul 2024 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721639223; x=1722244023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6KDeZL1mIopzYRyhCPAZSAzBi25x25dsv53MOad9y0=;
        b=dPDLY4QLD5+hC+fvnpHrdsKwQuZs+SaQMBzaHV/fHFbxAQb7vOp/WfkOsVg+/fHoMb
         yD/X5C4coTC/Dh+zAFHAUkV04JgGjAzKYhL0mrLA320LcKdPdbAoWlOSmnxxJ2Vfubps
         BsZOHHwbqcbfW3/aQkL/jT/CsO4xhCw6C8sXUu09gH+sU4ZcEhq3uv+pcZ1nFtGf+BV8
         Qi/gvoEd5uv3qDuIbWT5cFFCGLjy5CYpGjkROwhLt2Thcw3ErQOT19s2mftxJAPsuR+c
         LteVK+z3MguTzwR8Mqi0zQlMhR5mKZy8NbNptoTo8/QX+M9zGChWAd7ooGD5gIm7tSx9
         4Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639223; x=1722244023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6KDeZL1mIopzYRyhCPAZSAzBi25x25dsv53MOad9y0=;
        b=nUvoZHBXfhzSjQWbTkzdonpHStKdhGictPwMAaMcMXckIbUeFZ9xY1VJQTzwcJLvne
         P7CPmLoGc7/BSdlzMj+YJHiHMJ5SFUi+tCN8VLJeKhdvXnNU1UiQuSThs6bjcfnLVd9p
         1mrUJM3Brxpwnwf/ljXKZRSBq3roIsopu7V0aLicV4S10z28nyDJlfId4E0xWv/jZHYH
         Ro8iXJrmzpmo3FFdXnNf+L3LG3mZwzv9OWNASgzQibj0YlCWfPNx+xGVIcp1MeG91L6R
         npC6VPUMjVQZrCT6/B0qLK9IUU+9hTIT/rNYWRcy/mI0Bq5dV1Jf11OgYdzcwMx+CI7C
         r3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Vz2QO9E6MGeMn34Yyn4MH2Eto4IDRFZPFC7RKirWjUuBBVGW2fv9DgsEC1zn9Uu4NEgXe0Bg/roocOwGRcDXphixd40FmajXmM+H+A==
X-Gm-Message-State: AOJu0YwBuL0+9t3rhYLejIf8s5EjLewrExFp3srbvMFDfxxB6UTxeZpE
	e1Z8RnplSLnuI1EHukAQ6k14APQLfwAYJgLi9j29hEoKBi1e4c+Hfs7iZcnL7mg=
X-Google-Smtp-Source: AGHT+IHFXv/AlJ5AFRio6/mnRlwfA1+SuMUPkn58Vp4I8PzI9zyHIY0SW3KIC6yxvKFubCQIIg2inQ==
X-Received: by 2002:a05:651c:503:b0:2ef:2dfe:f058 with SMTP id 38308e7fff4ca-2ef2dfef4ccmr23347061fa.42.1721639223527;
        Mon, 22 Jul 2024 02:07:03 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7753abeasm7534290a91.48.2024.07.22.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:07:03 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] module: Split modules_install compression and in-kernel decompression
Date: Mon, 22 Jul 2024 11:06:20 +0200
Message-Id: <20240722090622.16524-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow enabling the in-kernel module decompression support separately,
without requiring to enable also the automatic compression during
'make modules_install'.

Petr Pavlu (2):
  module: Split modules_install compression and in-kernel decompression
  module: Clean up the description of MODULE_SIG_<type>

 kernel/module/Kconfig    | 77 ++++++++++++++++++++--------------------
 scripts/Makefile.modinst |  2 ++
 2 files changed, 41 insertions(+), 38 deletions(-)


base-commit: 933069701c1b507825b514317d4edd5d3fd9d417
-- 
2.35.3

