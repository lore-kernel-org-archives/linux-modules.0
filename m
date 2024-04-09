Received: from nc-smtp3.sdv.fr (nc-smtp3.sdv.fr [212.95.69.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1F137C2A
	for <linux-modules@vger.kernel.org>; Tue,  9 Apr 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.95.69.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679873; cv=none; b=A5sa6mnsTeLG9bHBX+gyn268YXoJ5abUD/YHapeyaMnEGsnGjkGQQH/9HmGGMUanlC1HuX/5I4o0mezjrRccGAEkT2y3Mlm1D+sLuPqHyWhyb+jiE/1YrqLorEGKpkYrMT1pgSLF8a1xgCkdCpHO27khpr7fKg2B3Egz2dpq/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679873; c=relaxed/simple;
	bh=q7yF4NAo1EsPr+kDzzaJpsqmLJp0/8YJ+D6sv8D237c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvTEV+5bYOrRAzkKYr84G1F+830a7uN8YTK9EVhWDx6mXMTOMpqb+2MQoFBB2x1+nOFnMl+/64WlbOOT9Ud5p5olDQthRXuWKHg3AZtjlLKiPltCDYLXtftBq8G+t5BttAQ8rOEoNSVZ4jFnfd1AKjQ0uAaMJXEurS0OOVHYcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skarnet.org; spf=pass smtp.mailfrom=skarnet.org; arc=none smtp.client-ip=212.95.69.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skarnet.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skarnet.org
Received: from skarnet.org (140.156.124.78.rev.sfr.net [78.124.156.140])
	by nc-smtp3.sdv.fr (Postfix) with SMTP id 770D0AF1C9
	for <linux-modules@vger.kernel.org>; Tue,  9 Apr 2024 18:16:48 +0200 (CEST)
Received: (qmail 35083 invoked from network); 9 Apr 2024 18:17:14 +0200
Received: from elzian.internal.skarnet.org. (HELO ?192.168.0.2?) ()
  by sinay.internal.skarnet.org. with SMTP; 9 Apr 2024 18:17:14 +0200
From: "Laurent Bercot" <ska-devel@skarnet.org>
To: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] kmod/depmod: explicitly include the header for basename()
Date: Tue, 09 Apr 2024 16:16:48 +0000
Message-Id: <ema794c470-aab7-40a9-979d-7b69050622e8@77b27b13.com>
In-Reply-To: <kqveepedg22645bfy77qkx6kd5peticn2qptbnewr2cx4uwi2r@vz5jui7rjysx>
References: <embe01a23a-c839-406f-b9f0-9b9dbd4bc5c2@e0f6f3eb.com>
 <kqveepedg22645bfy77qkx6kd5peticn2qptbnewr2cx4uwi2r@vz5jui7rjysx>
Reply-To: "Laurent Bercot" <ska-devel@skarnet.org>
User-Agent: eM_Client/9.2.2157.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

>We only ever use and want the gnu behavior, that doesn't modify the
>argument. Which is the proper thing to do for a basename()
>implementation.

  I agree, but as I just stated in my comment to the patch below, if you
don't want POSIX basename() behaviour, you probably should not use
basename(). GNU should have named its own (admittedly better) version
differently; it's just less error-prone to have different symbols for
different things, and I don't think it's a good idea to tie a project to
this particular GNU bit of carelessness.


>There's a pending patch I need to review:
>https://github.com/kmod-project/kmod/pull/32
>
>does that fix it for you?

  Absolutely, this patch is way better than mine and I should have=20
thought
of looking for something similar before submitting mine. Please merge
Khem's patch. :)

--
  Laurent

