Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E2D2D7DEC
	for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226328; cv=none; b=OaptVSGHHUH3EVVqXZOOojlYjPjMpaQinYMhfwmaLNVXSPNMIMp1eGxmcN0EG/9LZqzlM9a9bLVpr0tmAlQTv8wqNkGRKqSmzmveOd9er1QjMFNn3Yi2YkpfSabDl/DUbH58pVp5ZWHE92fX3HWfIunDW5n62A2dKIwO53Z4eWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226328; c=relaxed/simple;
	bh=ny1wrXLDh3RsyooyRx8m8um2skd/fs2vW4vIYfk/ANU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYA8RUYCwvHjxYnRlcvHmY3b35s/bSBtgpx4zUfzKyUkr11gHijyQYpDU8djfGB9/SMeIaJEAQnsbWa99xo+gwuidxXG76jEGrzL97nCZehAKBOOJ+8ZSSDZoCymWss5PniDh/Ac2K4M3gIr1IVK9KLvvqDwvLapnNFVE7TE7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLsGYu0D; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLsGYu0D"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80e2c527010so84641185a.1
        for <linux-modules@vger.kernel.org>; Thu, 18 Sep 2025 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226326; x=1758831126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpKJ4FYn851/u3+mSRW1KYRDrW2vMaNsMXQSquJ7H/s=;
        b=XLsGYu0DdShuSsoaSUFUO0WHrhEeMSiFGSrJfsdtDlY6e/NZcWcQWzeykzfG0LR7nU
         USt/7f+gFcm0PvuwOPwWgmhr1w33+ge11hVGWYM9a/qSLucA6yslo+FrUXyvi06A3aOl
         k3gDZ9IIx57rPtdrL9Y8zyvBMmWdSmm2BzmNlpAt32T7FkOFpo79viDJqj6ls7FMDLtb
         IAU1w4yQQIeKmzW3bOeSimp2jrmpiXeLC+fLstz6mhhYj2se42ZW5mnC7kjC1d9hqyNE
         QBRwyQZeGAFf4x2vwsl38pueWvh0FSb1E8uVYhRJpfKN2GYNS4fYTnozWFRikHJWNXEZ
         Kc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226326; x=1758831126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpKJ4FYn851/u3+mSRW1KYRDrW2vMaNsMXQSquJ7H/s=;
        b=Jpm4QsFsi+mS8Ms/o5zN93+HhCuMasUMnDfB+2z5Mh+RhqY62YIyWGZaDpQFS1GWP5
         g+5SpOdEW5DPebFLDOoeC0LGjYuTTNHHR4V4VsFS08PxZDp3nmBx21+Kl4j1e0ci5eCq
         rxkmACVIMZMoKiAvjAbHf7IU7Zt2NQBmV42kGO5h/3cqGcexN7SA0l3dXgL4EaWKQ2Jm
         WeN3/QZwUpEWhJuzj1eTah2CIGC3gS3P/lT/gftw3CUjMyMadhfzf0SWsIHnrbbFTFL9
         WsV0cVkZ/hzt1J6+EWdeC0Wy9WWOXYseiBWoiioha2CoRV7ZVd2CG7VE8iYD3uACKjOq
         dG9A==
X-Forwarded-Encrypted: i=1; AJvYcCWGC9fVdcxwp+AATlc5RQmXxQMnFc8d4Sf+zUWC0OlxtqiBXSgTgc0ZVQjBm8WvSJd3Fpqpt7oVPckgeSaa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04QEfag7GBHiC7AxSPcbW6hy/nftGW2m82g/PWGe/7+BLsAFT
	7od1Yq/28Q/SkFhP13QT6DUSLWPmOmtNC06YQNa5HQN52hcGiava8bzB
X-Gm-Gg: ASbGnctvG7EAwAxLhHJX1tFeeS1jICB76iibQvpcdhDr2DQf+X66LSGQTKeYh0m16aL
	I44zwQjOCSI1rjdsentT0mHB39w86zZQSPkkxvYSzcI3ugKGsdScG29sPKuKWfIR8Rc0tjmtdKL
	Uyzl1GVFVUmfKvaaLMWQZuTsBKvVhLSZCwrUts3+q3A4/9XS0EkVQa718U4HtLcPVtHYcifesPM
	wAhdw3Y3fvV4QyVX8Wj1WRYSsLoXcVgPPd4rcgIxCfhi9rBXjQ21S/VZkL4blpDoaBVYya6fUx5
	Gu4o65FlbxWzJ5yw/E1x757P5+pUXgsDMIDqYFOsbzNxcN2nNPB070pQppS9Ae3SvVepaezeHex
	B4FX8xxjEEPeJ2z8Lpd0tZ12UR127r7yWOqrSk26Ow188pT1vwsA4Wzw=
X-Google-Smtp-Source: AGHT+IHO+x7rpttILqBrr+bkLB4ACuWoLHRLLqhfpvVqyGjEJFvteQaJ5DbjiRTmgT2eKE95zYRvdQ==
X-Received: by 2002:a05:620a:12da:b0:82b:15c1:5a3d with SMTP id af79cd13be357-83ba2e7eb61mr109879285a.1.1758226326112;
        Thu, 18 Sep 2025 13:12:06 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:12:05 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 6/6] module: comment describing new codepath
Date: Thu, 18 Sep 2025 16:11:16 -0400
Message-ID: <20250918201109.24620-14-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

added comment so future authors know about this codepath

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 256e30259bcf..f4ce431163fa 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3220,6 +3220,11 @@ static int module_patient_check_exists(const char *name,
         */
        if (old && old->state == MODULE_STATE_LIVE)
                return -EEXIST;
+
+       /* 
+        * Can occur if the module was forcefully unloaded after
+        * its initcall crashed.
+       */
        return -EBUSY;
 }
 
-- 
2.45.2
