Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28051349AE1
	for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057781; cv=none; b=HN2lDWghk4ZT0otcr2PR8zFxC4UuwCxMY2cGNnOhDi9qzCC47m4/CyBFMyajFobw/LXH+7yOcwicJcXJJykp5vKqt4gpTQSPosy1QU1uWX3iEdSfoCDfYFfZsDtMfmwP42FkexVDBuZXXEd45t0ra/L7dBCa9vFsfV/RF3aqpBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057781; c=relaxed/simple;
	bh=tU2A7XGU5tMg3thsacRJ8bxh8G/tJCbsQXcLwZ+tI3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbCzuBTl9Mmkiyf7TMEAVcnPdY4hh5MlS8fO13jMgHoVfbanWzH+xIiCjyYSIaYiTQPQyYu/E6SOiM6g4Xzz1VX9F7JjzeM6AVX8V7CTFwlD6jlLMhySc4jV7E/UzmgdtXcpSlboesduwrWHfrcS4c02NcNRi0Xf7jtG+S4/3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enWCGSU8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enWCGSU8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b7bb3b913so2877072e87.1
        for <linux-modules@vger.kernel.org>; Sat, 10 Jan 2026 07:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057773; x=1768662573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07W52aMxFLKScpD3hgugCwUW4vLdsok57EM7soocvuA=;
        b=enWCGSU88UwstH5doadgYHTOI2MIMtPqqNVzvyMlAFmZmXbTHJM0r0go1coFkEo2o7
         TZC+hfcX1bsvWkuGUJ4S+qFFe4q8NBcRFJZ1TQIY9pKTwZTMMD0X6SYJchhm16MPBXtY
         X80WYB83frWircTnlHSxtCwkGOZG39uaRnUUn704N1Xw+0GSC88bw0q8Fplqa16VGdBB
         XHcFPS32QDm/B3r5AjLmT0QFUQeoJX3c6Mo7QRzNQNMLHdYyCi7WG+nXl0AtPiFCGwJ/
         g2/m0X9IjHHsJJlAninGMI+IqP2WfdrDKVPdgjqk9+WDyLOQ6ldbTgOMCHe5DsWpYTub
         f9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057773; x=1768662573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07W52aMxFLKScpD3hgugCwUW4vLdsok57EM7soocvuA=;
        b=onNg/Hioq+7GyWH4yRtvwXLJpHlzAJfPdMnytEgxgQFY68jmj8X80D7VuDClc2QcHH
         MIFfdkt81WCVdB8RzdYq/2sj56yYE32szomecGXcpeBPYSqryY1Gert30NDY4nF1VLp/
         /Jenv7Vj8oa38JUur3PagyUQPG4ryv6+SfmR9OhYuzIwtj1HticMy7ZlFqVeVwzWPRqQ
         1fIkH9fe4oX3jdvM1zXcce3Hll5pKzWJcoweYTSW62OgUAFb+dpn5hr07/JIdoLkHBhn
         9bag0R59QWYk1DZFadjbzhncnsMeP+PpBevZB1j08tx2XRj7k20x4EoVuxiDzVa6GKOV
         fANQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnyo4S18J2EKBxfDyWSeMO2wLePmOgYhzEDtUni6HTKRHTOQL7LJlL4mqhZapUe2ZbJjARg8pK8dl1ylmB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpix75GlOc1lS2wuRCkS35A7njWYm1CCtULChWM5bLaQfb2nOB
	+DAPDV3Z1sO/zr+gdCKR3/qJulebQZqXiGfptSbAhaL2it9bBQ4Oyc+v
X-Gm-Gg: AY/fxX6eMAyn/MxeIAeYhYrRMCEjr/hKfPeI61SoDHhM+blPTLur6RZSfXPgsHgquQO
	Cp6ROjU9okYSFtnxDxXfI1QNvl1tVLdwO5+eNc2aPNivxvTYVMjaeJKI/cZ50+IZ1fdprxJ8NMp
	oW7eVp3kQ7jUEVzbI5vKSncnZZ5YrxFDuEHyrKD8dmIaNQzQTlfpAjuMSCVW5VcaNnKnZo9frWu
	ss/acAGXJX4kRNCi6BVpDYKRFb9aMimbgIvH523ehLE4f26lWqRBXlJsFPobeNEHRMuPZ9Bf4dD
	0xVFcgqxleebTht3qLqV6bBme36Mm7gRblJ9vU31BQwwebNsGQrCHajbHNgcp4yZbs25MPbp/p9
	AMQ3h46EXIs6mqLFaWBZYATW5GIb0V8kzCsZjn5FEabKDmjFxdAVxrLNSAfJe41agRcG062i7NM
	pnCLSD7JFz4RWG00j+1F7KEbn6ACnYrpUkqGUJw4cHK/qyn3DNnv127UYPGqnwuxK1AGoPFcnOS
	QUYK+p8H+E=
X-Google-Smtp-Source: AGHT+IHZXip1FuDd41exkQ9+vHKMbxvmuRagUKcC4E8lHg1S1o+cppz7fFdiHyoeUx8UQxAGL2bEjg==
X-Received: by 2002:ac2:5dca:0:b0:59b:7346:261a with SMTP id 2adb3069b0e04-59b7346289emr2376804e87.13.1768057773222;
        Sat, 10 Jan 2026 07:09:33 -0800 (PST)
Received: from LT-5CG5341NQ4.nordic.imtech.com (37-33-148-7.bb.dnainternet.fi. [37.33.148.7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b75543a64sm2137059e87.49.2026.01.10.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:09:32 -0800 (PST)
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sat, 10 Jan 2026 17:08:08 +0200
Subject: [PATCH RFC v3 10/15] samples: rust: auxiliary: use THIS_MODULE
 over LocalModule for name
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260110-this_module_fix-v3-10-97a3d9c14e8b@gmail.com>
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
In-Reply-To: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Kari Argillander <kari.argillander@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768057742; l=801;
 i=kari.argillander@gmail.com; s=20251219; h=from:subject:message-id;
 bh=tU2A7XGU5tMg3thsacRJ8bxh8G/tJCbsQXcLwZ+tI3w=;
 b=QSsWUb0DnKp1VKyD+MbfnB/CFvwKQF3LVY1R8TG1xLAWCKovA2tX7wOgbxzvdwKQgbDYH9Ocg
 vh9HCi7TippDwUAEn8szZiHPY1G6F0uHGXS6Ehm5ZbX0qYfUyfMqauv
X-Developer-Key: i=kari.argillander@gmail.com; a=ed25519;
 pk=RwSxyhTpE3z4sywdDbIkC3q33ZQLNyhYWxT44iTY6r4=

THIS_MODULE now contains also name so there is no need to use
LocalModule anymore. LocalModule will be removed in future.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 samples/rust/rust_driver_auxiliary.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 1e4fb23cfcb0..84d67c5c87c8 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -18,7 +18,7 @@
 use core::any::TypeId;
 use pin_init::PinInit;
 
-const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
+const MODULE_NAME: &CStr = THIS_MODULE::name();
 const AUXILIARY_NAME: &CStr = c"auxiliary";
 
 struct AuxiliaryDriver;

-- 
2.43.0

