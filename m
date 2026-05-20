Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AC823392C
	for <linux-modules@vger.kernel.org>; Wed, 20 May 2026 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290017; cv=pass; b=DcXWZtErec75ywnDVdaVhR1zoIOHSTrTZldB7RWlzyvzzP/UPOY4a56RssuNjx9ipBp6ORMjRV8VXuNgs7fI2p39/QfAyqRHSR0gkZDFDmqttgTMa9/PVUxj5Zf5hQ1fljgut2aTggzFXRf44QB+XsTEUCf7gp+48Wx0jG9VIJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290017; c=relaxed/simple;
	bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efV5CkLZ+prK11ZHsn4Awp2R/jF15k8jIyswstQk4+dLcwLMzC1VL7ggU+bnS3hii04AHCK1OCABIhbfsdLYRSWMSvy+M85aOm08wz6Behxrfq5DKTzso6CcKVqQvOvGKuAxSxTnPZsJ1FqKh3Ybl+9rt2Fjs1CUbkmvTx24U4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNwwy7ww; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNwwy7ww"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso462a12.0
        for <linux-modules@vger.kernel.org>; Wed, 20 May 2026 08:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779290014; cv=none;
        d=google.com; s=arc-20240605;
        b=XxR3iYnVZZxLoKSZ1vDgA6I8WfafEBAStuUi5yqzJXXt/RuqbDhg5Hlm+xnxEWjumU
         yoVXviD8ipJQkFpHxr2/sSMgMnDFISRmRjb7M+LgkG2G47DlAx0UmailwPZe9vy6C9yr
         84C013nSKQmRX/5AlD3CwMIiOspSfSZl52zAXWhDE2fXHzihXvc8kAcuqrR9MVLKwR+m
         jOsJtlpz/no7TGW9P2TiC3Ah2ko0c534qp+fh0rTlCAL96JEtRsiKgA1C4W84Cv8OCbb
         Yfuy3/enTBnjby9ehBbtkR1upwUzxZkmLVcCryFLr8aXJhpyYI4TtDZMZEdTCrzHpUK/
         CYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
        fh=YzHBlW6jxyPXgBjliJwI5ryjZthBegKicRcaJaHT2Ks=;
        b=JIOSZVVtdxVyslQJ1TleT/J/bwLlxgI0LDpLAnVj58lUnF2KZJLW5BV0HDHriUkBep
         6SRsa8hstCsgBH81X3QGukHrzeyZk4hCQZk8NPOQlfGKm7ILOn5EWbYboo9N6d7vKm+Y
         tZX36AlCDFgqBcnHDcP3GPFRamYabfvwbMbqPoo/OFadbyLXQBnnkygLfna31s0aWVhk
         Qnfs2AR3vIBMm7N5wqA1AKPnp4tMLFWfcx+mt5bVDpyh2FUtY4GR+8Zhr77IjOseKhf+
         5y02U8+v5+xfinJc5WOPKStf4W2xSgZnmvFeSYPhn1f0ymA3LnvZLeUmAhUvXWFnwn5d
         rGdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779290014; x=1779894814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
        b=NNwwy7wwTGLcUsVkwQqHdrF3IW3iUaL/vxuavvVb75JyG1RtYIswHA8TnpAOlhzVQP
         /g7l2oLySO2lsPMVbGA1zWQTtpwUVw02dKSdYCcbOzfKwJd5tJg+GWHc3atUQiwOGD82
         Hj32nRwLlhBnC0ZVArD/jwdGsTfk3Ls1p63302HkKADafPUE87zWncdOmgg+8y55QG7L
         ilVZj280NxMa/Bjb5E+2e7eFFwWIcgvtWFHMMIKj0fssGC3Igx5AjxTT4dLr9t2IY0EI
         vXac3SZNj2XiEtCq69tUbnLENzXwMTTF2f9XGzU/JZWr5MiRRnDkTTFGF9npJ9FikOea
         F/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290014; x=1779894814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jDm5atvhHuIxeQV8hGmizmK+8RSolpSQCrjOaP+ltM=;
        b=Jrr+1NixyuAt//WecYgA4Jt6XXM08/rAl/Y0d9J1vWciRuXcNA6Q5NgJIzYgvZrBVM
         CWEMD9A4Mj9ynWeR0gNuOUREGY8NGm93mBJVEOl7eg1GmZTwqUxrNFtN9L1gFkDbNELR
         xm/6948F+zRBmD9UYbMqP5BceLrQx2N5Mphqdpa9QdDaL4zK23tWxWeZww+NzGIXmwRk
         aUr1cmC1epJy1s/h0f78iGaKs4g1fhRhHbaVC9KRD+Qsqmc80ZcsAs+OFVHmi8CXQAr6
         1HcOgdkYqViwfX0njfpNfuRhiYQNw5MB9Oi8aenX9KdcAPHWwjDRhTL1BgqiLuaMgVx0
         qegA==
X-Gm-Message-State: AOJu0Yxa0rx9jkmN/NMk1oD9DvQsuDy6S9EAogwzhspXuIKFd8VHU/F4
	wBd1YNwAOkZBKJr/8QfGuUz5u+FIBJV7Qof/XzoaS8JxhZjgVD0Scx5P6kNZ4NBcSYuMNv7rckE
	21A3dyJbHLwhaxIOX0ywIdegxhs9iSW0oW93tGZnK
X-Gm-Gg: Acq92OH/9f5RhNh8qZlBS1/5Gu8ahhVfF3h16AxdW/N54oFX2k3scHEgdKkgiW3OHIu
	C8lzIYBiWull4CiDJhR5/HC7vVjZsnlAsmQLkPPQXLVRu3LgV/7TopS/6VBStSfUt4JQ4qzak7t
	LzlaTEhJZZRjAZheiHTOCdzAdCBo0jEn6LZahTq0Ru7S4OYzcJ7yZZI7B9kpDowB15969cJg24y
	8U395ouxat9NevcAt9szJ9K6nz+zM0sO0EceF6KioLmOmcf7ErS1zIYp34TxW7Md5gU0rOL2YfV
	ogYu0LW2LtalUbA=
X-Received: by 2002:a05:6402:52:b0:671:fff6:f82c with SMTP id
 4fb4d7f45d1cf-684891acef2mr234306a12.2.1779290013807; Wed, 20 May 2026
 08:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com> <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
In-Reply-To: <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 20 May 2026 08:12:57 -0700
X-Gm-Features: AVHnY4L6eZ6JdOCJ4YxM5npWqzTWyTozwWpMd7ccTT89uumPUpXazMBZui-XQ2Y
Message-ID: <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
Subject: Re: [PATCH v2] module: decompress: check return value of module_extend_max_pages()
To: Afi0 <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org, 
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:11=E2=80=AFPM Afi0 <capyenglishlite@gmail.com> wr=
ote:
>
> Hi,
>
> You are right, the commit message overstates the impact. The actual resul=
t is an immediate kernel oops, not an OOB write into adjacent slab objects.=
 The fix is still correct - checking the return value avoids the oops. Shal=
l I send a v3 with a corrected commit message?

Yes, please send v3.

Sami
