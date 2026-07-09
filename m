Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D43264C2
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610779; cv=pass; b=RQ4X1FV+XJRAJMpt57B3CQMlKr5snhpynUGCiLXSKT9vDGBRNpEGlQHhfOynOrwmAtio9J5Wi+j1yIgjpvyLpzuLYs0u8MxT2yFiNmUWrIG69gcWuW4pvVVh7pXkszBGEK9OMkOMqK5QxpMG40tOE07YjHagy6JZtJXmkaLdB+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610779; c=relaxed/simple;
	bh=RADE5skwR5CK6urh/a2qC8JtgrmLIlKgMowcJgh6G8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S11ZamoEjBQ5/mBfxTt9NfMaDCBiJ+FYPa+P8ojhnYNVZUoCjD+nQRTLEgNQTtmFKWmHLaaFOIs0RCkHVkrU3ih/Xeyr6ly2UTR3iNC/Gh4Y9RfOg0VkobpSzsSGpk7Sg51fSp5y/B3k4AoYPZxWTENkOEr2Mk1+NHRk5jdQtzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPtmL7zC; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPtmL7zC"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so268501cf.1
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 08:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610772; cv=none;
        d=google.com; s=arc-20260327;
        b=l7xCiYBgDxd1bohJMNVYq8IzZn54NzvBOy6hn3+g1PPIN1KPvS1GoBd4ADEHRW72Hv
         C9fE8lKJ3z1CSUpbsZ2W4eUb8JfhYpn2tO5vx2PGFliYwlLaAxv1652RUYSTY/M/EJtM
         GZdFfIcHlwidToXSRSk5Cdlj1lOJ/ngHowSreBTTAY4cZEO0PCKQbExk+qCigTgrSqG4
         gUDhLmIeDFgaObVesL4paq0QVu0LRRHV0miiCKs3D3aMLodepUng4TR59KMprX0Fzjpt
         n45biRySvFeiDOAWx4I7J3KyBQt2zYTrjFADicc6QdlimoWcT8uKpUnZL/nH6TsNhNNl
         vG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RADE5skwR5CK6urh/a2qC8JtgrmLIlKgMowcJgh6G8Q=;
        fh=s0i0AS97i2LJaM5oyb5FWrau0XYhc8SYZdNyTCmJF3o=;
        b=s4GMjTrQ+ixcg4J2NXb0lzeRdjlRqs/sb9wgH6o1G8gklGjmaL4Qs0xqdA7gfSbvHt
         hFnHh9tn6Fz8Pw6eMYzJDUcytnkgKAJHFgNOSDV11Ok8YfzTERJaqTUnEst8YwGJWwUG
         Zm/XRsfaRLsDDrzMAu0l3b6mgGypI276g/N/DvIST1BmnYPWmqAVgdte5z4jddVmeL/4
         o6c6Ue/QYFZ9TpuhT0rVJOuJiZZK0H/9l6ZmAT/NbzhL8S+VBm5YKSZmXRzTq3UYtmp4
         Gt3x4Xyv/HvHgSc46OuNM4ztZOq+nPErDvLNhsNpdEhoqh74KyVfgwRHHkrWaA0Eb2fM
         LzVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783610772; x=1784215572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RADE5skwR5CK6urh/a2qC8JtgrmLIlKgMowcJgh6G8Q=;
        b=UPtmL7zCTKP/VQG+agIn8XDaqM7yjqhLMp/ktKY8DL7cY6SBf+NLxYu9tgUeBjJKJ7
         FfVfwpnCEI/H0DagyFgI247sJqUqQin2Jf3Ghra4q5aMuCHu0MsesHEe2iW9B987YecK
         6JeXSfw+oVz2kgvmSNCe+qPo2ZRQFgV62i1Zt5nUZDpdV4v4ukmLtvbjgS0789wWtyhd
         9W26vdkkOHCWGhR0Jf2fecSixPvJAzBLTApv16Kw7Ip/WEx4dk83ytjz9qorZbf5UI53
         0zbQzHSPQVr/uheS7ZpMkXtSoEchxEiwPqxa08UA+I2AN5K3c9Ihh5MtcKYLDe+P/4xq
         GkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610772; x=1784215572;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RADE5skwR5CK6urh/a2qC8JtgrmLIlKgMowcJgh6G8Q=;
        b=bwF1dCkPPVXuYDoePJnOu3L4QyEYROeFSc4dQTcuGHGjP+zWHbz8jV/Tuipw9pms/u
         p1NqThOSXGaFmPsd5/UukY9KgxdD7UTyJ+JotFZvLUhQ93hSWW6xpTjpulx3BMKHksK5
         WqcamUjvoXLig6efKP/oJJVpYqg/Xb09Dqcqf4QV2Xp7AIRTdvP06BMyh7xu+1PwLgiD
         bIhjjOq9q/Y55vYvHYUbvk9JR0fESyuG3m9nopzbtWRgIn8vGIMJePMudQ0I/S9c18Pb
         b8dYDS2psN5VrPOpeDlI2VreRdQdJWivONietaDS1wT6PdrHx+F1Myj32sFFqy5sIGeu
         V+UQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWc4ZzgfS9VlL0mNzbWztbpdvEkdlRepcZO6NWFrOUyA+xhPUQV/XiLW0cDXv9OcM7Ithn/oxwrXogxud0@vger.kernel.org
X-Gm-Message-State: AOJu0YyqtM3F1DRvV41nby/99+46ioFU5rbKBCiBbOZ8SXvuNxLOLh7l
	F83lcLi0fhaoAQeE+BGH0QKWbkGZdy4kRl1WlAtmjsxZlMSmlqZYnFXE/UffQ/1bV3YlJG9INi8
	ZQVlt26170QaQGo2cHbTWFoXTfxL0p55IiYviotvc
X-Gm-Gg: AfdE7clvIVDtcKnwKBzHd4bwF0nLz89fVFypZSk8YHkP45xqFr+fLR7lAdlJSx/YoRs
	cBQdZHBYTzGBpjNWTqsWYtJ5TTBsOp8sOvMGnvTdMB9/6oiHNsFLXATEM3Lsl5qkjTckn33ucte
	IQGtM5/fqH1pwzeBe8lP3vsIaQTV0KoXwOpj185gSPZXZJmqSrzj9kQKHcWhjpelAbV4W3tYtSS
	jJ5r0Ux87O8MXMLQWamad9ssqiDiwIPfIz3tDq55qugnS+7ElxzEIvMeS7C5Ejun76B6g==
X-Received: by 2002:a05:622a:1ba0:b0:51b:fd5e:e81a with SMTP id
 d75a77b69052e-51c9a8c2c1bmr8320001cf.20.1783610771703; Thu, 09 Jul 2026
 08:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bl63xtwmzo42pw4636lr75u7duhuejp5tariokl27x3wnvdu24@3xf5cupsskka> <833ca499-09aa-4eca-a023-e3a7168066ed@suse.com>
In-Reply-To: <833ca499-09aa-4eca-a023-e3a7168066ed@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 9 Jul 2026 08:25:35 -0700
X-Gm-Features: AUfX_mye8Mr13P0E31X6JnTzLg6Yp7E77wQ0GObwWLqszxoc4naBGzBV6c56gjU
Message-ID: <CABCJKuczwBmtKXiyzh31Efwbt6VfwUpStLPjXkUFNHwwSPQA5g@mail.gmail.com>
Subject: Re: [PATCH v2] module: procfs: fix signed integer overflow in module_total_size()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, mcgrof@kernel.org, da.gomez@kernel.org, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 6/7/26 6:18 AM, Naveen Kumar Chaudhary wrote:
> > module_total_size() returns unsigned int but uses a signed int
> > accumulator. While the result is numerically correct, the type
> > mismatch is misleading.
> >
> > Change the accumulator to unsigned int to match the return type.
> >
> > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> Queued on modules-next for v7.3-rc1.

Note that the commit title still claims to fix a signed integer
overflow, which isn't accurate. Otherwise LGTM.

Sami
