Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F935E1C1
	for <linux-modules@vger.kernel.org>; Mon, 13 Jul 2026 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985886; cv=pass; b=u3WBQgAb5GA7EdPBo0yei8NNEkYRmzOp7IUQ0loUb/iTa3f7gALhfUdHqUbszRtb7c7gYSLcLuTKpCBLqUeLNFDFM2xlfb+KOfTBPWTDv81l9kBgmXMYKs8+QL2o1Zocjc0km3Ja8uT1uWO3t33NoF74opZ49r3Tw9jmzpC1UHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985886; c=relaxed/simple;
	bh=eFTiNkhrPO8WSMO+GRp2GynqUrMhkRKJhxOxNfS22+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4ffanAaoETPyuZ2qWPwC+9rp1ErPXnNwkmAScw3DwV9O/cjZLPvrmhlnN6Z0xlaGzaudpaGAt75wbT32meQW1pVAya5t/+BdKY0XIOF4jb1LXVAvX2EP/eQNym1X6bEpsuZ1An/p8RWxpR4G6DJOPVBzG46Xnc6Rcj9+SbbG0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5vPG6dM; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5vPG6dM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c15a5b265so121881cf.0
        for <linux-modules@vger.kernel.org>; Mon, 13 Jul 2026 16:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783985884; cv=none;
        d=google.com; s=arc-20260327;
        b=lOLRIk/WFH7Xa4scqMmJuit2KM3G/1P+AELDSDtaKekaRt1NZitlCwQQ+GFUodYOi9
         vUv0cEPAO/kyMLSLX0i+GwwvnR+fId0r0LPh2vrOKpZJves9tEdGsu6jxsNUu/jdIolR
         t6aijeOlsX+K/KLljqHsil8JFXbkE9wwacDuEVMU3Q2I33QqGAVgklbrZlA6t2cFs2kk
         4EAa5HyAydP7+mTZrb6OZod8xSL7QDvGl1R7jGkYSYeD/CJLu8D2pF0dlx7tFdLsoOe7
         UWSxhSlEN2fcMHhSlvGmrmcHne2qbr5uRYSLxbsTaQXYr0Jxo5iY/K3+9k53x6Q1pF7B
         6GBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eFTiNkhrPO8WSMO+GRp2GynqUrMhkRKJhxOxNfS22+8=;
        fh=EnigytA0VB3s6MzdGBUBTKIhHTd98qEF+h20RTUUbxQ=;
        b=iCDhurnpiHAbAKMr6daObF9/jr+KogrehTGloKvmc6YOcC0xTb7sT3djm+87oD7lWG
         NfBlIj0slU0SDr8Pg3yBT4lJA3s1y86hQQygez3mFmouHj02IA1duoFKyT/ehleIcG40
         FFX3NZ2ehs1LUUo19hLjd7BN33HQNV+eptUwJqPcyXtcTm4mfc4xBqwq/3mzOtH+VMX9
         J/i302DVyJcbdoG9uobJ3bPCAGlnS9BCpYQo7NM/B93T3thECUbLu4RgeImx7PKxe6eI
         HYvgYPrqEkJkYvxns8ahnMDF3egR+jhVAC4h4v6dkELMx2HQ3I+5wvdjXlbDM7VUzOPZ
         dI5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783985884; x=1784590684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eFTiNkhrPO8WSMO+GRp2GynqUrMhkRKJhxOxNfS22+8=;
        b=D5vPG6dMgqWQrHJPcQQwcMsI22GGB7ichbYYLuch8nCo7Q41+MsLzZbYIblYWO/KQz
         Xf/8hiiCW0qVO5yj+VVrlYKKI9A8sBBokoj79OReHP0g3SEai50TcEhpnoCUAQYMfvgH
         PKFpg1f/5IqlHPj+/GzuAiKDWyQ/0RT2GVfuvpvru0UOiASCB60pL31Vx9NJNTUVQw46
         lANxHMfvCIDajYHyukuOtpL0vp5fhg5M5txXX7RpcvUn0VTCZfCRAGyQ/hDtkVY0v8Y9
         WXpJn9+5u3Ow+3Sb7xl3aDir8Vdp9mtdJD8RDg2SqF4uvvMEVxIfmc/VSeUtZmNSelbk
         VTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783985884; x=1784590684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFTiNkhrPO8WSMO+GRp2GynqUrMhkRKJhxOxNfS22+8=;
        b=V3wQxGWBc+md/rvI5Nj66azpiTHS+bs3mk7JpTb4RH3ZHe6SB0qgY+hqO8rpbC2ZeQ
         dSmn6eEPXasCj3vAhuUOgTtr7GJo8sVqbCjPpNgU7q/F+Zj6Qj6J8yLNCXiNOImzSTWW
         rudaK6VnsCJEDYIwLHdz2YvP6p70mhOWITv8rP2lbdeiVrt4ClkQD1DDZi6M7/WLkMoH
         ydoC1UG7ZpaB8jChAq+tGI9xy4sPsAv1qjcV2TIEoFe3Pb6rjCO8n8p6HP0HxYqrJNa/
         7Mg+Ql8WX+LtVSg1jgxFe2uU/AuJaB2wDrCUmdUwUoPjotN46hUppp/4MkmEDCrtjR/r
         q9vg==
X-Forwarded-Encrypted: i=1; AHgh+RrEGTcgkWrpEA5/4vyrmCy0C7fxEkodnvnVl8FPnFLKsB5TgPfOQadTY8uyie8nhLK6Dc92Ntfj0T/9W8Hv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fIpMThu58uy2Oo5KOlZc/jkTyDyu77Dyvz1+hqS/jlwYEKGR
	+VkZrq27YWci195o63N+n7Snj/TR1fYpg6PRKHI0GRS8T6jGMJKWe5WO6ke/TCFth8HIqmvdVqm
	f3XrCgE/8oxWElFhy/qcriXMCe4fbG3QOLbxds6ZG
X-Gm-Gg: AfdE7cmdGJL8sKj/8QfSVxytROvnfPLYJGghVnX5m1dge1dxj5LLrIpyH7pSLvYtZeb
	VghqUP4i9r3S+xf98DDwMKFy3/05qRPzZQp6Q2tyvKh7CsbsHEuTlsJqrDUNwcUheoC6Rradt/Y
	l+G4kxlHkMhXqHffmSfciplj1eWPZksnt/Lv82yP+QXtIjEoyLZSFqyQ/wGpVcr6m0ZxKz+66d9
	4RLWemfmTCRPh+xDNfHa98Aos1nU10vUY6rSn6kYMm9h0ipASvosMfsJjX77UNzN2kLHu7mfyRd
	d3CQqcb6Klf33alEkGYOJqzRHFcSvtR8VjU9G5cUKiaLhMRb0gxcYSt8ZGW7F8g3gKk=
X-Received: by 2002:a05:622a:1f13:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-51d7bc99378mr8915051cf.5.1783985883619; Mon, 13 Jul 2026
 16:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708012107.1621513-1-tweek@google.com> <99301e32-b067-4d0a-a087-2c77b1fe0a90@web.de>
 <j46ht6nbnztkkkjbcxgx2aq5msszjsvxg7cwffxdrxciihbzen@p6q6k6hakgzy>
In-Reply-To: <j46ht6nbnztkkkjbcxgx2aq5msszjsvxg7cwffxdrxciihbzen@p6q6k6hakgzy>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Tue, 14 Jul 2026 09:37:46 +1000
X-Gm-Features: AVVi8CcJGo64LxQEPtx3X_t29il-FQ0A5z2tgYJacB2J1rJp3H7oBMeK4yohNUU
Message-ID: <CA+zpnLexK1qbCxpwQdP76B+F0JqCFJL3rEWnp8xShbLbepvuXA@mail.gmail.com>
Subject: Re: [PATCH] module: validate string table section types
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-modules@vger.kernel.org, 
	Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:14=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
>
> On Fri, Jul 10, 2026 at 10:23:00AM +0200, Markus Elfring wrote:
> > =E2=80=A6
> > > Validate that both string section headers are of type SHT_STRTAB befo=
re
> > > caching them.
> >
> > How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?

Thanks for the suggestion. I can't seem to find any relevant commit
for Fixes. There are
ec2a29593c83e ("module: harden ELF info handling") and potentially
3c5700aeabd87 ("module: Factor out elf_validity_cache_secstrings")
Both of these commits already intended to harden the parsing. I don't
think there is any regression here.

As for Cc:, I can't think of anyone who should be explicitly added. If
you have any suggestions, please chime in.
