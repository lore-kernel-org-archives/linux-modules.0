Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BF233935
	for <linux-modules@vger.kernel.org>; Fri, 26 Jun 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782436402; cv=pass; b=dEWrOxUcXFGG5JfcXnMWwf09P2ZcekKjguyE7bmgGkMDIuazgntBg3m0L25mY/LlEvIewfyQ1mT75YOk9Rmln6AA8LB3xfipEN8obHXyMK2fLFOxUicYuljV5gN7XPzraxG81FbENF5ECyGTrUN6QPd3nyZK18fS7WAMpgVQmu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782436402; c=relaxed/simple;
	bh=jRyMsIs11r2MRu6fNT1VWtbou28AKL3M5y70TjhIbYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlxCbFAYaegDMiGAQctZWV1kzOfSQuUoc7/NcztZuGq284HobFjgNhx2da0JCKoLmLfQPwbOZd2jJFxxVJ1HWE+Sryq1THxdpYI93hvPWt4oYKKZxEufjDx500JiIatP3sEFdnWTEIOqk7+xfWolpvDY5MmbpvMV1Q5xyyViFk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qU4vlocd; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qU4vlocd"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51765331535so73021cf.1
        for <linux-modules@vger.kernel.org>; Thu, 25 Jun 2026 18:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436400; cv=none;
        d=google.com; s=arc-20260327;
        b=RvM0Bij40MhvTrW3DB7yzMKDb54tVyhwCwxkzFEjuP0Vs0YO/px5LlmNzA12wH5vSF
         d5TU4eSlPGoEIGeqCqQNAMqbH7t7MGk0hs8+IvYgPf5qwd+qwbPKWsfg99zCDg8bQKkG
         2u00++gJUsfL5SEZzOAkX6cRs4g/1lrsZdbLKwLL6mNNIztltEyYvSyAePQW/7f2ZTQW
         8D9qt02ptK25CtaDf2GhRnMx99jhYCSJU6wp2dkkpC+aiQiWtRqYiyeB9576m5Ah8whf
         cCtoUlLOaCiPHjVv1JBP28J2JLLBuMfgmjDn74mriaqKJasgo9sE16hIFArJIu0or/px
         OFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jRyMsIs11r2MRu6fNT1VWtbou28AKL3M5y70TjhIbYo=;
        fh=pkydDUpaiOZDLLJ3jluYX9shnTObDI+2LXYtkXhGkec=;
        b=qQc1QnZszCPjFem/W25t0QaRTSHhRTd4zMebVgrkczU5lMP0d9toT1ziLY951SO38u
         M55F+RnRDW+TGxhIv7jIBTDkeARrzhbgBNiMWTe+PDnqcrx4LyTJlIArgYPeqcR2E0ZY
         fEMjBSqES2AO/+7grdGR8QjUTt3nmNGLfv5xuW7CXf1Yh3LnieU6vGPlp1EDV9qRY6+0
         UCZvupOckQKsoi8hrlOV5fNLjF0cZWDdziFoIeZJVWCfv5/2DQRiqrjejbqy85TOQSta
         C1Y5DMkJTB8DJO1TtoYyzyjsbKAHJUVyfhm8zdv5zd6MhIHtS3fA3q0ww15rKroBydtY
         9N5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782436400; x=1783041200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jRyMsIs11r2MRu6fNT1VWtbou28AKL3M5y70TjhIbYo=;
        b=qU4vlocdl1Pr8so1EravWQRF+12AFyoqg9EXazpYa9RHdCXNA+CfZDyQ/MS42Xa+WE
         Yhi8AgZ0Ije5+inBcdkgyMazCvILKibVw9vA7vvdhMQL+qWwvMS6KwW9UakGJJ69yvBP
         w5gLTCh6k5ntvqVXtMInYK7X7ukmUc9uG/FzKvioXIrc9fsu/Oqt/PkFBwTg3ak4ZYAY
         ha1iqU7VWotdoxrqML9DHgoMeBJQpnyRKtblC6Xz6KehTaMys0LZIqCsopgbXYrGIIYv
         9coNtXrdYnytfdPIP5gqy4qtiwL06QC83u9DoYzeRF6P/8wrifYC+CU7H33kYrohuIdZ
         lXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782436400; x=1783041200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRyMsIs11r2MRu6fNT1VWtbou28AKL3M5y70TjhIbYo=;
        b=Vh7iswd9QJ7l7ZcXVt+AeTaxNmYfte2GFK7gli6zw9Iq6CWpdAqb3x+bQdn8g9IF3T
         oppGYEMiDsnUyIYfBRbURZvZbAIXAVQs/QaVgdSOlA0XABB1lm1uUkNX8Ur0FA7YvY65
         sbGb/bJQwoDS7ntxYxa+RvTQfY5Z+myzJYSdOfn9c7Pvf0TSgf/Odf0xIhvwn+l5YmGE
         wjsO5o1hnCr5iDp4lsxZ1blKSmSB5vO55nvZXWlEj2vRshe14bUR4yTQFTlh8c1fczWn
         VOCzGkwWQKSmc2WdtbK2ssoDjKN3pEi0TN5FWtyl3NHz5C+zNZk+460Lyvq7ihklVZsg
         yQig==
X-Forwarded-Encrypted: i=1; AFNElJ9+Wbh2H4Wq6GqxJbCaq893EQzpMkw4GhwnKEyD3JqLb9v3XUU/2BoYUyaNtPSix9ZR61ZKpPum5QF6G2iI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EWdgofiK3UG433WM3gOR/YRD4l95YHMJbiYHVfdb6Q8RlQAN
	4shueEK2R3SnbCQg2lYLxZ+U5sfQoYjxhVbKhni3OFd1T3D9ppPUWM5e/egzUOK5xec5+bEiWIv
	vZun5MSeUew5QCEe+6jf+aLWIB89pfTUEJ1ez2i2k
X-Gm-Gg: AfdE7cn3RR3OjEei6O40oIs26OW7ZsFhKXEWmEU2cG/heVH7hY1kNg1CvvAz/bqvbKs
	9/ZD2uO+08+s5SiAJBCNZULkxYDLcDi0aJghbeT3JEtnjQRRaacQNnc2M+KLCDQlqP/tXMuHA9o
	H8fa4dygL9guCQtT0nP+TXB6+hMSucxP/Vc11F8rzXaDr5mjiqXXI1KpS3tNcm0kyamG0/BaR1X
	8RfkWUyjGEumPUD3XV3COLb5EYF9lb4lST1X7ZU0E2Vvub57l17B53LzaTr6oaxD+R9CWBsKOE2
	1X8I
X-Received: by 2002:a05:622a:1e09:b0:519:b655:235 with SMTP id
 d75a77b69052e-51a7d918f85mr4051721cf.3.1782436399662; Thu, 25 Jun 2026
 18:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310023807.80140-1-laoar.shao@gmail.com> <aa-6wILF90Y4ndnd@infradead.org>
 <20260311224420.GB2440964@google.com> <CALOAHbBQhOsNVemgdtj2qLMN=bwqpE89ySqgLOMa9DY3-K4y7g@mail.gmail.com>
In-Reply-To: <CALOAHbBQhOsNVemgdtj2qLMN=bwqpE89ySqgLOMa9DY3-K4y7g@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 25 Jun 2026 18:12:43 -0700
X-Gm-Features: AVVi8CcqfXZ1h1HVLq2yBOfNvHANxH2EV1rCT3v6jIy0gWZXwduJ22FRHVx0RY0
Message-ID: <CABCJKufaZMfhRFu-FJj6eHgEjkxmhPYpxMoiYMyp1U0j-f5RJg@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Yafang Shao <laoar.shao@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 7:49=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Just a friendly follow-up. I noticed that this patch hasn't been
> merged into linux-7.1 yet. Could you please let me know if there are
> any further actions required on my end?

Based on the discussion here, the consensus seems to be that module
versions do not make sense in the mainline kernel and should be
removed instead:

https://lore.kernel.org/linux-modules/2026031341-evolve-repeater-987b@gregk=
h/

This reminds me: Greg, would you mind sending v2?

Sami
