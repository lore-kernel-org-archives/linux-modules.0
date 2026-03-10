Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30E366823
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148347; cv=pass; b=jzaHo6ftrL31s4svGY7vBt9YrupPRgERQ+9sTSt6BGyNTw95F8qUQUphM9GcGTLbXrD1iQRi9vSSMWMwTtQlLIDIUJ4UiPt74TIuxM08b42h2NZVASf0FnUDq216aeIHHkX/Ew9nIlE3o1ABJ5wnEaeaT+q2lm9TLbuEdkR7OP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148347; c=relaxed/simple;
	bh=TjI8Fm8tw72+QsL9EVKOxnYJH+4gfZYvgm0kWRoH8U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C33Tc7yRvMUqHnnCNNreUtVya4LnPtmbm/bVvHo9FWz88ybwmV69hKfCzEg3Bor/64cic2Z0YAWExEA0xozOjbI+NmX+Tpy5t7NIhLg27g5lkzb+/q6Mxr4/HSP0gJh1LZljjxdwUGMESynytgAMECiYIzKalDQWnPmyNX1mlYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9E2vIHI; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9E2vIHI"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so11018074d50.3
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 06:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773148345; cv=none;
        d=google.com; s=arc-20240605;
        b=AVexqFEBfn9hE+Rimc5w7TWFXp2FRr/GydjGJdUc2fCIH0loMbBdyJ277kPWVrAQx6
         5/j2PffEvzae2pUjajk+8zQa6nRz6L0yccr5ezFliLPY7zAWHw0GC/MBwAcMEchZi7Gg
         P6tRrDqIs7ATktRAbuEbaf59EZhjyhewnwIX8OLPAG/Q2qNyYe5yIIBzhsg0pr+BBelT
         038+d0kt0hwbwRH+0ZgxXCXaj5iwLvGDi8gxW0Dre3OubW3vlsMPv0PHFOJefAnl/DSf
         +3PTdracnHzxgsTCU/whELic5grNJ/HlR1PASDRblk0SJlNCY5lD7qkVKh2sgc7ON/uQ
         qxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TjI8Fm8tw72+QsL9EVKOxnYJH+4gfZYvgm0kWRoH8U8=;
        fh=mljUr8qmZegXYyhVkjaV10d3uhMSsdy7+txBYsvgVKs=;
        b=dbvmb2qq/I80svPSsLq/gV1TaVnYJDzOlmKaybbXRJ9W18uo7xHCmX0HtLf3B8IOmV
         TSbDeuQKaOnwi3ecYEm0ibtjz2OmDjKRiV1bzBWD5x0PDNLJymO18rTwuOnT0bzG1CTB
         srb87Hngoh3XZC/m/FcIS+aH4XWlCEghmYiGOZZjb86jvKcnOGmPJGFE1JXUyEOZffH0
         sfT/GnUzhEe8xVMCHCA9GGzPVzcPeu4YNJ9u9lkfD7OTEdZCao5SrEl7AbbuDnc80alP
         0aKM5sujxooIbTqxi+f5Rtt3Fc/Byv5L4SqdJ3eLc/lwSp28Vb1/4bba4+DJC3NXBJ1W
         zONA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773148345; x=1773753145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjI8Fm8tw72+QsL9EVKOxnYJH+4gfZYvgm0kWRoH8U8=;
        b=E9E2vIHIXRIJ17XeMNwXVvKuDHq2/EwUjdu1sqWjR2Z4mhxExfqsQC1dbJLbYQJMu8
         xjgEM26gMTrslL4nGxN4uLFa2l9NKg+Y0y/uaNkdrE6kU3UbbAoDdNWf3z0QrgY4m2EL
         nkfirXdAEdNRn88TM+MrzrxSQWHMk/Pz02OmF3vRzDRTNjuZTWibIiVRZfRrZ87HvGQs
         tcs/f/bYuW2XyzQKogUTz/9U17abiwWHiNUA7mqvDJdrz1UchWG/gBhknjK9yJu5zKRZ
         iJh5evpHAKuQ3sWlX1cTjmhNaSEpYFOSzaCnwvVc5IG/mHjswtTaPL5K55I0uHmJeYag
         IO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148345; x=1773753145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjI8Fm8tw72+QsL9EVKOxnYJH+4gfZYvgm0kWRoH8U8=;
        b=qaGIU4rA/vu0G9KfOFFQ8i1o1jgD0E38XOLbF/QcQY7IUcefhWlMKoYn3yZ/yus5Zc
         qiynErdJC60MSmd8QkhmQq6dT+OM+5DiHLQahz4LC9038KvvmmwWgcDSH1fhxMB1tTVO
         QOIcEMNWqLF4PBo306yfxHm6/hg1ul5ibSN3MAtAkPSkyMIB3Idx6UK3Yn6XCXeOXx2e
         W7XTmcNKtOoNhSCJmtbjhmW1GrgG/NLmaC5NjQCGvxYOyI22JbCvmlkQQ/V2+3ta4Oc5
         BlQDVApKNYtU6tvIpuATG06X1cVgJJT+adCozmqDl5e6nHTvmN18ZcabaI3zpO8jwXb5
         AdHA==
X-Forwarded-Encrypted: i=1; AJvYcCWh87bp9rXds5erZIDlhLGCGNUW+W4d2kGRPEYtNL8m9MhttvRXMQDMiNEDR6aKu5WzLg2p7uS7gRl9j0q/@vger.kernel.org
X-Gm-Message-State: AOJu0YwGovFusHwC3LPFIEZ7InT3NXcW0ze7wOPHt+0nokbLvVE/igtY
	S0XZGinR+Ra/kT+DVnb9Ot/30L3tKmZ/ZAssHanpQVIZWbmpMoZKIM199INTjMEyU+Qbq4G4h4w
	4+vB2HepLlFnc3+5LatMOIit7Uxz23Ss=
X-Gm-Gg: ATEYQzxJgEz+3bwDIUl0FP24sGZuIIT4yVesLeBQDGiWQWhqhg6zHzQmN5szN1nzYXg
	U4kSooWImXzg81chf9Z7n409u+9VOSIMEnrzMOhqUQ9dvbULzMWHnrfIqYo39xRVHS3xGrlhbKa
	RV+RVTxlGUFS/6llKMA0JJdOACr85rONQK6UWbzI6SmottqKReT9fYSaqkf8IhNbMS4O4OgzHp4
	8HlKn4Q3tVfne98pVvyAiwekH+9DUI9WHmaXJ5RhoSd3xWf32m85C4oKmnKQ3Hlt5tbRE4Qw+LF
	2zmi8HtrUz4Ffs12IB4=
X-Received: by 2002:a05:690e:1409:b0:64a:f1ac:7bc with SMTP id
 956f58d0204a3-64d1437dc20mr14199076d50.79.1773148344794; Tue, 10 Mar 2026
 06:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa-6wILF90Y4ndnd@infradead.org> <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org>
In-Reply-To: <abAXjc6OihRcdoAA@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 10 Mar 2026 21:11:48 +0800
X-Gm-Features: AaiRm51PLiyHf9MXMHUXJ4uo_nhgan6Gd8TxqGaZBMZnRa6_4AMCcog3jPM3Nbo
Message-ID: <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Christoph Hellwig <hch@infradead.org>
Cc: atomlin@atomlin.com, da.gomez@kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 10, 2026 at 09:04:14PM +0800, Yafang Shao wrote:
> >
> >
> > > Then don't run extetrnal modules, which are not a first part citizen.
> > > Get your changeas upstream instead of just leeching the upstream
> > > developers work.
> >
> > That doesn't make any sense.
> > Could you please explain the rationale behind introducing
> > EXPORT_SYMBOL_GPL() and TAINT_OOT_MODULE ?
>
> Your straw man doesn't make any sense to me.

This solution has been approved by all MODULE SUPPORT maintainers. Are
you on the maintainer list?
Please help keep our discussions polite.

--=20
Regards
Yafang
