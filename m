Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505244;
	b=UefDlrzpxuCrUMd/PHBx8owkohdLW9S266G3mvM0prfFyhenhRLPje0VuqMYhF79YCSl
	 aDJ/yTv5zVB0iZYWSNoKF2xoYZdMeH2sRjR57wnWSSPEAEqZ+/J813nUpEsmIIladyG6s
	 JgZNBGxaFyXwR8F5c20ZXPnY8V86ibxxMqYvBnOTG1HomKCipx+Gucme0xRg/5z1A0Ejk
	 GrxpgV2mQIi7WIsybHm5gFZMmn23EIpZhiecPbOX+GaOPrKJNUjhmZOoVwqBDywoeOFix
	 srWBlIexHi+Fj3n8c3HVbMdgao9tDXDD6uD9+whlwKOk2yesY7m4XSJhrNlYdcKVVhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Change-ID:Content-Transfer-Encoding;
	bh=ZwhZ/50JHDB9yLWk9aI9TESDQvyJFGrH/l1ZLQxcavA=;
	b=iUwMAMs9QbpNfvxQahVMIxgkEDhbOCtVWkgVOmyjwKtqk5/2VPkOh9GgUzAqdz9s158a
	 ZQLKFGvaWFziUbUp3SruMUA7aJeeZo6XmsJtl8doLKGsz4jkrnCcfPAN1Q2vTfzZAmdK+
	 GGOyOqsOemQSoQAiYd2DPOIf7MmZ2VZOKUXxl3pSBtye4xae8H9oVukFZdo0y4V1XkCuk
	 N8gDtE3uErq5h79e2lwHRO6+oftqOrHpPBkjOvSuzv0hcqnNFj8uSUkKDFXsSde8NclbW
	 Mi/Wkc3R5GDP61/WMXk9EbiMVIAPSrrCUfryV2Aqxw7V3K1yCps7Jz8NG1NuVebwomg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Lri5ufBG;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D9606A323
	for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 14:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23D9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Lri5ufBG
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso16255745e9.1
        for <linux-modules@vger.kernel.org>; Tue, 20 Oct 2026 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792505241; x=1793110041; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZwhZ/50JHDB9yLWk9aI9TESDQvyJFGrH/l1ZLQxcavA=;
        b=Lri5ufBG87fd24lVSVAM9X335hUrANc3syGf4gi4pyyF5iklwS7xBy0a2KbDBvfCg6
         4/ZN6UBEqZEBeVyr0EB3lgtGA34Oc4Fp4Kzpb1V/VkhET7WTYw8HxTQh7xj/spqNHiPP
         fUD5tyKu9KG28kCMYD+tueG7SgBNGH38kZu0Pi/3SQ4UjAUH8Ts2Xpa6OYFiuZlAnSKc
         nDrcOTH0hGhz4gmAg30Fd2wUIhsb0xyrNSWOhfwdJNGMxE2AgSpO3XKjN3GuAqQkBNa4
         UURP+dmGHKTBqgFXgLrQ9qrUl0jn18CpQteDE/YEns55hHIuju4cE4PWlelw1JssHBSI
         c30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505241; x=1793110041;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZwhZ/50JHDB9yLWk9aI9TESDQvyJFGrH/l1ZLQxcavA=;
        b=ekhX66/c3Wen9uc1+wEkVK8Ogtt/2zq0dbVqlUpaJF8XbJA2FXb8allFqu2llBOIDx
         zxCK+WiFCB+BrlDH0YE1l9KlcoSV0fyn71ky/Qqnl4aG2d9t5gNCgWoM9Voqz1fARqlg
         0Ie570JzsLAYJ1eCq4yP+iDt89nUoBXfYMkHljfp3sQTi+9/xavLHxJE7Lk8hHtMPZgP
         qH8avtT+SoUCOCA6KI+okpdXl6u8TzjwZ79Cgtjj9kzURMREOuvLHE4mSLEqopfe5lIY
         2gHffenOYvtbrcLJzs0IvO2JFclAa/JVJyPYobQ4E2cqOSL6coSU1jAlN4sYdJxHo9Hj
         sekA==
X-Forwarded-Encrypted: i=1; AKwUvBwL9idqrkSe5ZCLHtwvLv+Uud7jvu5m8/piGfv/jGE9EijENo9qQRPJ8gEVSAFc5qiVdQOt1nglVMwgTcQu@vger.kernel.org
X-Gm-Message-State: AFq9FYJSvD+P4e7w/zrIm+YzEdNTipPqHLcTVf27q143R8L8nRgTVxJq
	AJe0i+QpkltR11c6xsEDmDnKxRt+TxLq7108tFMA9fcFNksvjnQdYAppyzi6ZAqFEd0ZzowOcaz
	E4tfHqt4=
X-Gm-Gg: AYBFou3o2XGsEw1RS6Gjh77Kb/vQzd8Bx0cf+GcEeum1ZEDp95SGxyRVRCuy/u9kSGe
	ClDWNXpjsl5wctEnKMI5F5lDRG31jmLxV5WUugdkVM26c6j2g8y3VCkgXdKO6Kslzvkr4FvW98f
	gazqPb5ERIlHFCYGd3YyRktHvpsvqUxVlKTE8AyacUBld96SCk7oMEro6vLkcq6+FHU64tPHt+i
	rZeWq/r7BUV+1ND8KJHF0DoUHlQQR0YY8nHzleuoake3FFOq7TaWuGIz21jDaEQMMbrBitg0XXJ
	UfqQFkIzF+91Dq8MYpuTDr4Z25Iz48QYKkSA01ese0T3mnTZ6S3I2FxJ0KDoBt8Yhdp3XozP6qP
	GP2pYyTxHGmt/khOnbEn4O9+kBVIT1256VLdr4x9jdd2yUQo0EMeRJdahp8cTSXkCCf02rs3X44
	cnCaO0wvMEzfNpRbpFVVlUJKcJYCPmhM2V9AdpkjEgccnyhML1mY9UwbDDf+6hgS8+Mg8Lca8SP
	AYYPw==
X-Received: by 2002:a05:600c:3b1c:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a1d76046dbmr241521495e9.13.1792505241294;
        Tue, 20 Oct 2026 07:07:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2ce1479sm75602805e9.14.2026.10.20.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:07:20 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] module: Fixes to tracking taint flags for unloaded modules
Date: Tue, 20 Oct 2026 16:05:18 +0200
Message-ID: <20261020-taint-unload-v1-0-d1c764889afc@suse.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261020-taint-unload-f96d25823757
Content-Transfer-Encoding: 8bit

Fix missing taint flags for unloaded modules and a data race on
mod_unload_taint::count, plus move mod_unload_taint into tracking.c.

---
Petr Pavlu (3):
      module: Fix missing taint flags for unloaded modules
      module: Fix data race on mod_unload_taint::count
      module: Move mod_unload_taint to tracking.c

 kernel/module/internal.h |  7 -------
 kernel/module/tracking.c | 28 ++++++++++++++++++++++------
 2 files changed, 22 insertions(+), 13 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261020-taint-unload-f96d25823757
