Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F649638
	for <linux-modules@vger.kernel.org>; Fri, 14 Jun 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391021; cv=none; b=s63X6dW40G45Yo4viUEGwJaTyDR+lgMWVR/xJQ7e0K3g42lwRpSVusu1qDBvvZxcA8r3ZKTcLTILwD25h+yN0zes7AoGz5exd1SsLGBXQ/36nQ6qgsS8zC2xnDSlDacE6duYr4QK3aLVYJnI5SVf7W3aKrF6riY/gv1RHPmxut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391021; c=relaxed/simple;
	bh=EjpeBGFL76cL0Wv2lB4YIkGdf+IEz8MSKKpSImxLBsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grCFVk7byFD1561gm4N0oJaG1rtjA6pmzNwh6sBETBIhvxxI4P+rQxm70ifqWnJFy0/6OF7WTKxS1oHw+/ytQUjM3+aXYF00Aw07l52zp+po/c4AWwYuAB5q3fFQMuXve+BEWLpWPcCWDMfOvP6a2+T9ex0LSqua1AQBbNBtzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq90+i3E; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq90+i3E"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b08d661dbaso31776006d6.0
        for <linux-modules@vger.kernel.org>; Fri, 14 Jun 2024 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718391018; x=1718995818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlLbXg9tWpS6OCcN/NLeGm/QfgF4Au2DuEybVrSlVvU=;
        b=kq90+i3EQGf+Ygvp6eNuVR5LbXp5tKoiDlXwWlvz13d/YnXQCj+rWWZWNoifr6+n21
         At9nOfDWHfpLYPMsasPTkhZdNSq7r/ljtjf4RVKpMR29fWit3jzH5/CEEdaFuyvHSV6S
         H8/wtjb1BuyBLQicoumaFoLGS9+SFvpfftOUwkacaFybBeJvkCMIdYVPyFNnkPnu3Hun
         mHroqj2yh/phOAypIrzeBMY5SQju9FOvAp7PLQqN4ZpakisLY7FR3xtIVAe2kel3axwN
         D1lo8YVzNXLoImgz8MRGDv4xj0Ys2b+gS21ZJAu29AnQIev8Bbaf4vBoDFztxdI/oKwH
         5Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391018; x=1718995818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlLbXg9tWpS6OCcN/NLeGm/QfgF4Au2DuEybVrSlVvU=;
        b=Kq0vsbgasuVYBGogCE7jkCshR2OoLkEySVY9Sf2LB5R/Mptur1/A5cGrTUo5PWhtDt
         5sk/dIEzMIv1DkJ9uP5gG41I4XktjkRYkozSsb+4lnH2zTbJyb6oq+STOG4vZ3e/ecfu
         wECFQXvfF8izdilKqzG8nEsYjhyiVVGS2WTcSpA8K/HHhKx6wYHH6fAbaEfD5k1qVsCr
         HgV2OiSAg3FcWRODTS6GotZlrUBbGdm1SG6jOxAcGaR95Jcmm92W0PomR1DDSuQfKtMQ
         yx2i5DVjxTVTPEU0g48KpHD9ncUhmT8fbO0Q+384jnjc91k/4yjqj6xCPkV8yDOc4QFB
         wUzA==
X-Gm-Message-State: AOJu0YweFp+LgvDZf33lBzwY1YsLBELiSewFBVueY8B0u9K7dR+3uvgi
	x/XI/Soin1XKKONUEfuy4WK1osFYVLOpqlJANriYh1BpFC520I/PIr21vzax
X-Google-Smtp-Source: AGHT+IHyVIQUUBYOri2aHDBy7Mpp6nFfes9C0tNzGG3ounn/uYxhbso904qrTt9FqNuWSL6QxmKAvA==
X-Received: by 2002:a0c:e601:0:b0:6b2:ae35:2fe with SMTP id 6a1803df08f44-6b2af16eefbmr68981366d6.0.1718391018058;
        Fri, 14 Jun 2024 11:50:18 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([134.134.139.75])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee56cdsm21377366d6.113.2024.06.14.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 11:50:16 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org,
	Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH kmod] .mailmap: Forward to my personal email
Date: Fri, 14 Jun 2024 13:50:03 -0500
Message-ID: <171839099571.438551.180101549540416739.b4-ty@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611-mailmap-v1-1-69ce7f7ffbe6@gmail.com>
References: <20240611-mailmap-v1-1-69ce7f7ffbe6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Jun 2024 15:34:56 +0100, Emil Velikov wrote:
> My Collabora email is bouncing, so forward to my personal Gmail.
> 
> 

Applied, thanks!

[1/1] .mailmap: Forward to my personal email
      commit: a0ed4f84387e39e637a63cf9a96c7fa97208e1ee

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
