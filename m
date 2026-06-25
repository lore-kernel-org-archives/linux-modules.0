Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C426B755
	for <linux-modules@vger.kernel.org>; Thu, 25 Jun 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355797; cv=pass; b=FFFU45JHI+vn3TTi/JnKl/o1ZN19NBJJwcIq9mgjBlrQCa6xdSKmWm6EeNG5RNyYlw+A51cznp29c/b3sfYqwMTSpismJfKahPT2tCWkMHe67F3e2q2851UAD6xefQURmXbQyf0MjQY/E+3jRuRDWQC617LR+7denUBrLgHl188=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355797; c=relaxed/simple;
	bh=65RVjUN/oBIAIaBoq9T+amp4LisJLBuGc5W+2eAb3zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nipzMD9jWEQ/TfjdhiqY1wePGugydMp/SN2urlnGYcaIHzsS3w/PAnquGGd+d/AWa/YtnjFTYR3VUMCHCvCbpf3Xw7bRJttKG8NveN1e0Ct8zM1UbeIJoFh96P3oTzn861DRrPnEh3v8jEAOjfPIGVv+G7KBU0FWfUiDzaONQAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5TMz4Ha; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5TMz4Ha"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7fdb04d774aso24657177b3.2
        for <linux-modules@vger.kernel.org>; Wed, 24 Jun 2026 19:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782355795; cv=none;
        d=google.com; s=arc-20260327;
        b=WBk0//HlwJw9OgM4H7ORgovoDzVWbuOJlzruwcRm8wH4ripDhPHd0vXewTQyw88EVm
         2udLhGsaYOu05SS+0yL43PDOkKQ17cfiKDuYR1b1GrZAKyPN2YYD2K+asMyMWCqyx6FD
         SIHhYs2V6r/6i9w/dcKrMI+l6VhcEaMabs6A54m9PZQGDd/l5BeZvTdIoQTSuGaUfMwb
         fImReblFNTUWoDwqgQlKmHd8L6izzmG/CSCGXRMQfgl8GMgSO8ie8AZKJuDjtf/drkWZ
         Go/L6AbxNRfWxPI5HjIB/Xa2VRHALQELSLYDr+P2/5LihfO1n8d7trp7wJOvda33TWQj
         m9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=65RVjUN/oBIAIaBoq9T+amp4LisJLBuGc5W+2eAb3zE=;
        fh=EaXbiTpJZuLwmTEUnUjV6txG4RX7XQ/Bad7ID6UNWzE=;
        b=b9WBix7cLWwvGPYAPLp3fnQyUKD442fNx80LUY9wrHhOm6eTsBn4R8VgOQncPTp6/G
         F0i/1AI/Pf8yFN0v0/os+Xt4iGfagXGHj5sa1AEgUwjmoECe3MpTI0H507u2yiP0dScP
         ZH4lhyQw8P7UYl19jZa1Dpp2uEYFZK8iGeAEdLHLtAB8a3dLBcOyA6iTvpku/QXnmH1x
         IARqGz4L+hZr04+dsje2q0AdsUV2YsxRvifs7BMa7whXuRA3QU+ygge5W+s05K7chpJs
         oYLBBjvS0/fEEqZyNbbSwONUHkBTFE0eziqpAnYl6RtTWUGJxxyHfgPAqBQynGJsdrU1
         B4cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782355795; x=1782960595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65RVjUN/oBIAIaBoq9T+amp4LisJLBuGc5W+2eAb3zE=;
        b=J5TMz4Hay8HsQwm4Bnhb2pJ0KBBZ2I4XQ8BUGOrUrSEz8hBcqhp7Ax82IdNsFCkUb8
         izLHZuz6VcEI27AsK6u+KblF4N6EDTAPc5Ud+8yMuSrenkmUXOoBAy3Tahc9NYktjstl
         PorzWk9rTNKHHJQQLSHsiyfeUHMHwZAcKz12Bw6xeKRXSey1VzSwBboVk46IamMbbYxI
         AGOaaYPKJfh5m0ABLYUTp5wUlAbMgPkMFm7ihRxGvrLa8oN/Y2D46dqFRwj6N7ORtewv
         rBsx9UIsnESD18bLUlCtTVKk62dkRB/is627fneGkbC/vj0Z7bK96JM1xhhkg94voHEv
         roPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782355795; x=1782960595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=65RVjUN/oBIAIaBoq9T+amp4LisJLBuGc5W+2eAb3zE=;
        b=EVlXgTK7rCifEfE4osmG6Xq9nPXWPEO+bthYIu/xOdHg7ePL+wAwTkoc5Zdn3/fWn1
         Mtbuv6SZ0m3XKS+y9yv//UEyQzgo5FqQJeFDatS+DYs8ob4BDkrwijVTMTEri66icd4H
         vrANPHViJj+1F0QCKsX0cNxashV59iFFIgeWwOHpadxO/osyyAka2rLYumOwPtaUYwk5
         D1AwOxm2B2IK4UQMgZsmEql11j4YTClA4CbwvdeF5reptHuGaKN9jM1uHd+hgO52dE4W
         1S6vmxrUgXpb0ZU2KAxteiRhqQqBvgxbXQOzYRzA1HJn3fd4Pz0Gz+2BowMrBUidFn5b
         +b/A==
X-Forwarded-Encrypted: i=1; AHgh+RoH7M1SyLiKtc7yWIr3sSu0zfxGFJ/p0qzlIQXjZ1ML8HcHaJfxOJoA2loC0WguLk1IVue24VotPTiD7cEz@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJKasJlasBycwZsBssNUBmgQwCWIRVLTMTZ4+LFjQHtluH+qA
	DkTkAKLQQx2m4kVMHnoS/o3f+UKSH//ugqBEb/utDh3kDQZRhs6SIP9b5qrTcrQgRy+ImfA0yjw
	3SlARiwmUtaCABBLg2WF1PxgAEa8yJms=
X-Gm-Gg: AfdE7clYHJrgg+1WBVFF4OgKB8ZUVDLZQAZLYOGfUayQE/in+nr6gi418WRlaZFDJDq
	ZuqrQrMFTUAd6h+cmn/mlN3fwnxKv3qh2Lo9HwQon5Xr+LT6VL+rOB0o1Wv8VqIP7HvObW/tjrA
	rLAaqXknUY+FFrK59o0WRM1UNanmSuU/PHUgounZTZA7Gb/RsJmnYfKrPBbMoEakBqtXeLMjVLJ
	P9ltp57Ek3Dev3phDMwO+JUiRCC3hVm5r7bBMB9puhkATOazVg3LTXoPDIGD939pSWsE7tvE16y
	dmK5bwuTOAb/6QF/8QG37An3GY3HAw==
X-Received: by 2002:a05:690c:6d0f:b0:7bf:107b:f85b with SMTP id
 00721157ae682-80a684e89afmr7897727b3.13.1782355795161; Wed, 24 Jun 2026
 19:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310023807.80140-1-laoar.shao@gmail.com> <aa-6wILF90Y4ndnd@infradead.org>
 <20260311224420.GB2440964@google.com>
In-Reply-To: <20260311224420.GB2440964@google.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Jun 2026 10:49:19 +0800
X-Gm-Features: AVVi8Ccw0FHWpRuhLYsl1CZH9OZUuZL9qV52aX5FUqBcVJfAp1AlULjEZ4hKCB4
Message-ID: <CALOAHbBQhOsNVemgdtj2qLMN=bwqpE89ySqgLOMa9DY3-K4y7g@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 6:44=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> On Mon, Mar 09, 2026 at 11:31:28PM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 10, 2026 at 10:38:07AM +0800, Yafang Shao wrote:
> > > For vmcores triggered by a driver bug, the system calls print_modules=
() to
> > > list the loaded modules. However, print_modules() does not output mod=
ule
> > > version information.
> >
> > And it should not.
> >
> > >
> > > Across a large fleet of servers, there are often many
> > > different module versions running simultaneously, and we need to know=
 which
> > > driver version caused a given vmcore.
> >
> > Then don't run extetrnal modules, which are not a first part citizen.
> > Get your changeas upstream instead of just leeching the upstream
> > developers work.
>
> As much as I would like to see these modules upstreamed, distributions
> do ship out-of-tree modules to users. If adding the OOT module version
> to print_modules() helps folks better handle the resulting bug reports,
> and maybe even indirectly keeps some of the noise away from upstream, I
> feel it's worth the small maintenance burden from this change.
>

Hello Sami,

Just a friendly follow-up. I noticed that this patch hasn't been
merged into linux-7.1 yet. Could you please let me know if there are
any further actions required on my end?

--=20
Regards
Yafang
