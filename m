Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5B4C6F03
	for <linux-modules@vger.kernel.org>; Tue, 12 May 2026 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580799; cv=pass; b=lLYPawYJ9mbDBsep9loUWFNUY/fpIprDvZVcc7BPZxj+vngZ1KC+jwZm9mmZHP9U4xRaK9PLa+CbcLQjRgVRicQZkQ2EbzFWcIO9PyWIDsv1/wDz3v+7A8IuDkTxyzKzSnV8htC58/C61+HYtC/HyqRn2otE0Gm5KEBbrJJZVj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580799; c=relaxed/simple;
	bh=3JXviSsNS05f6c95fuXgojlVZygBTpvh0eQQs8WkfiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRrM+S/9JT0VTrC0lMK/tczoI+BYQ/dpgJTikvIHCEo+zDr9PHYrwIhFhty4w6RLqKd8nG+T4HKyfR86BQuhsHriVlH0M/4NjsYhb8TYSAYIQkyyq38y/VbsUcl0R0uTQS2JkP5/a5j/vyYAp0xyTXDZhEQ7ULGVmXGCeT627NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0rJXY1q; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0rJXY1q"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7c2fa14795aso16538777b3.1
        for <linux-modules@vger.kernel.org>; Tue, 12 May 2026 03:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778580796; cv=none;
        d=google.com; s=arc-20240605;
        b=BfLdMxqudp/UkJYM+c9gKUjwxNOR81jiX/kAeb3jjoX4+7kPWACyzEpoOF31oXj725
         TA/eWRL/Q+Ii9rvsTn5NN2GC+4XGNoBn5Ztnn7hkSbR8mTRzgYjnQlnCKm/u5EG922l8
         trihmp+DYkHmt8M8XPHjezFWUzPxjV1QwKIh0Id/n6ke5SKdcPLO8vYwNgM9OvsUmyvT
         9/52IRTNgSZBP2Lvu1MbFfjFoy7ZS1AXnw/BwgxIGte6ecmccYBFnBYHx9xiCJ8/3El4
         iMUTegC2MqQd3wPTfRHsdAsKkGsDrpa0/j1MpjsE4A8Iq/lkoKVXw0mZYH1wKwW1RoXJ
         FCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5BSZqOS+TrqkUHbWv/C2v4w7E8GCl6EcU8pMI4+NnO4=;
        fh=Vsi9GMUlaBSSuyAnEFabCfht/V1TL5cc9qEEf+JvAHc=;
        b=Oui8UgQCdzMAi4LzWlMxMgy0SNayr8RhNprNMzbuUkWCNgTDvj4cWPjCOrZCeL9XVe
         bcNqcgc8sxmYtH8i77CwQ4Lhqhqhq/dFWBPoJGUpM1yckMxgWnglekLoa7D7wRNUqguo
         GEjbZoRw0R74+wihteQ/avEJIcd5oKDVXliScwfgdEcKeDWOyi+7kgkWfTmEg+JLHbzi
         0g2j+NGeCrDV/MEPi+Sr2KoSJUmcG7gjM1L+rOdvEz/ZwuqF6TqjygOm9kauJEM+VLqt
         esyGtpINKpOVR4Zm0di45lXqskKbYMK+TS1EXOMJ0CF/gxdUSLzCh7IQjApWxbOEfYdi
         qvog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778580796; x=1779185596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BSZqOS+TrqkUHbWv/C2v4w7E8GCl6EcU8pMI4+NnO4=;
        b=d0rJXY1qXMP+qdjzen+4W6TpacmYAQEw1wV2s+GTrt8gWLhaOamJ0SPOZyHHUyI6f5
         pGy7+islksyKuw3htw8inCJEMv377G1cdqt30AWubqQR+VNeFcpGYq9PTw+77P729oPQ
         BhHhTyzsscS7zRStrDAUCYOiYXa9bEIV4CNQ9QyhlLWDz6nNIrhT/PKgxnstJzyvvGzq
         5HK0JDSZ6uRWQde04yROY9f4wabk1pFgG/kYNK3bnOdWGkgKMxP3gPmk95l8+dGqlLq5
         Eje4Xc4GMQ0Xws+gVHb9SrdWjUgrTiDU8bOrkXwfhTjpvyRxdL4o6p0gm49zKtXOrgcm
         lOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580796; x=1779185596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BSZqOS+TrqkUHbWv/C2v4w7E8GCl6EcU8pMI4+NnO4=;
        b=nj80m6HBYSrutca5YYnXh/qpFmp4XoxXYVIj5aE7aCwk0tk5LnTjy2jybron0PQGIk
         Px+S+ewcPfjTUw4B5abb0C99pknLievNc1k21sO1VGIuQ8XpGbdJkkj4xynWNe2z0WmY
         GAxKbuBWYwvjZaxzw5rTfbdZdt9edd0B01YEd+kOsgkTcCiPeJSZNndAT4pU8Q5iJolI
         z+Rj1EsP9cT4+V5itV7pM7KeUB29BiE+Tu07cwxPgjfidRE577i88SGsmWOULB5U2rWt
         KdmQBsmRN5rZCjNrtTHyiXBS2Ww6oO6P6cV+J4ZMSDPwMTBzdoFw6nARqxnH+NRJvoPu
         ywmw==
X-Forwarded-Encrypted: i=1; AFNElJ+GJwmW2dZuwZdXtzRND94QI5rr5WAOOZUPsfGXS1DYwPHP5vJ10C11lLJ903lcGhJ0+tdz1ZhirEzUtyDR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0I4Bg2Q4qTFzGH0HNmzIxxVKpOf5HXBMQK3ixykQX70QPDkj
	+svjxiQkC1V4v4QzNv0pVpFlzI0AXiAfeL7hSp3Oti3rCGxsSljyMbRsVZCuXaeTTwfb+d3df7C
	AVLPsfXD8pjPEHti0YqwvpPwzOkwyAJc=
X-Gm-Gg: Acq92OHRB9oZVDXdaF0WQtRsu6pPN0L3F+rwhS8TwgXMzQc3qIQIZasAzjkPHMuktOq
	ZsnGsh5c8y5fR7hKWFn5YWorZnAmZL7oHoImYhyTOSkWm2JN7spJyPBYqPeF7FlSJj3EqG+bNiA
	QAsIGwerwBInN5JhcIMsoCMJ27woRSoLhtg70KkjBKmCIfNuElDqyeemygWx5C0oFLtS+eKRqVL
	9pAHrXDaLz7B40uatz/W89nCKORZtCB9GX4kbK7AdF28bpVyujYYpk7IaSByd7KH0Hq2b7gEsay
	BXg=
X-Received: by 2002:a05:690c:4d47:b0:7b6:f4f:f057 with SMTP id
 00721157ae682-7bdf5e9c436mr289758407b3.24.1778580796530; Tue, 12 May 2026
 03:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com> <20260508190121.3461706b01f6079bbacdd167@linux-foundation.org>
In-Reply-To: <20260508190121.3461706b01f6079bbacdd167@linux-foundation.org>
From: jim.cromie@gmail.com
Date: Tue, 12 May 2026 04:12:50 -0600
X-Gm-Features: AVHnY4JV_Kad_CzJVZ6-hA21hwnqEtvGFXmvgfMclci-oTVYzeG4JisLmLwYre0
Message-ID: <CAJfuBxz7t08qiAxrDuUkF6_6pkjG-nK_3tn82w+Kbt+y=XZxug@mail.gmail.com>
Subject: Re: [PATCH 00/17] dynamic-debug cleanups refactors maintenance
To: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Documentation List <linux-doc@vger.kernel.org>
Cc: Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Shuah Khan <shuah@kernel.org>, Louis Chauvet <louis.chauvet@bootlin.com>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:01=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon, 04 May 2026 14:45:06 -0600 Jim Cromie <jim.cromie@gmail.com> wrot=
e:
>
> > This series is nearly all maintenance: it refactors/splits functions,
> > The user visible change to /proc/dynamic_debug/control is s/class
> > unknown/class:_UNKNOWN_/, which is a more visible/greppable indication
> > of incomplete class definitions.
>
> Wait.  We can't make userspace-visible changes?
>

- the code has been marked BROKEN for its 1st, intended user: DRM,
so there are no users affected by this change
- UNKNOWN is an error condition, an incomplete/incorrect classmap definitio=
n,
and is expected to be caught in implementation or review.
- phase 2 of the patch set has improved compile-time and modprobe-time
validation,
they would catch this coding error.
- I will drop this patch if these reasons are insufficient.


> > Coder visible change is to drop the enum ddebug_class_map_type's
> > unused vals - namely: DD_CLASS_TYPE_DISJOINT_NAMES
> > & DD_CLASS_TYPE_LEVEL_NAMES
> >
> > These allowed more symbolic named inputs:
> >   echo +DRM_UT_CORE > /sys/module/drm/parameters/debug
> >
> > But theyre unused 3 years later, and probably not worth keeping.
> > With a removal commit in the log, its easy enough to restore them later=
.
> >
> > ...
> >
> >  MAINTAINERS                                        |   1 +
> >  include/linux/dynamic_debug.h                      | 106 ++---
> >  kernel/module/main.c                               |  12 +-
> >  lib/dynamic_debug.c                                | 504 ++++++++++---=
--------
> >  lib/test_dynamic_debug.c                           |  28 +-
> >  tools/testing/selftests/Makefile                   |   1 +
> >  tools/testing/selftests/dynamic_debug/Makefile     |   9 +
> >  tools/testing/selftests/dynamic_debug/config       |   7 +
> >  .../selftests/dynamic_debug/dyndbg_selftest.sh     | 257 +++++++++++
> >  9 files changed, 582 insertions(+), 343 deletions(-)
>
> No Documentation/ updates?

I have 2 doc-only updates I peeled off and sent to @Linux Documentation Lis=
t
Otherwise, there are no behavioral changes here to write about.
Phase 2 has API changes needed to actually fix classmaps for DRM, and
docs to go with it.

I split out phase-1 to lower the barrier to review and apply.
By your response, it seems to have helped.

wrt sashiko review, Ive made several adjustments, Im reviewing,
working the others.

Thanks
Jim
