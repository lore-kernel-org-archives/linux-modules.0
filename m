Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6103235063
	for <linux-modules@vger.kernel.org>; Fri, 16 Jan 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606522; cv=pass; b=hbdWblDqDtATqYCrZ8LFJl9ByADfM7Q6cirxzkzJOHJAI4jBKNjsaYH09+gjfMudVi0UCziD2k6lSyvzQ8ZziS/76C4/DQP/OQbmeUclJqKNnwjkMOTyLHQ+npXoz1KBCPO8UPMS+LhGHokpZeNIk5mCAB778ZjfBHoqHHvhji4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606522; c=relaxed/simple;
	bh=x8FFDlF/fesOWEb5mpSebQwC7vWTQTshDMbtChx063o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmOWLcoclFNn0aYzAfkZsRAfqZGt+xFBFJoAVHKoyIVPmBW5Pn0vZ1R9vP7GucqlipRWC9LpJd2O1hjvZ7Hbv8mz+UNX0QeIBXF605n/YFiPFFttq2qZhiAuHXjb3C5NVJ/Dzgpz6vOAgO6cJh++iEW+S/vAzXE2kPLp0tKfqm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78e7ba9fc29so24274597b3.2
        for <linux-modules@vger.kernel.org>; Fri, 16 Jan 2026 15:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768606517; cv=none;
        d=google.com; s=arc-20240605;
        b=UE4mX9MWwCPBmeUk04MjaoLpUOmgggD/ZZlgKeonOvKcdU4Dny7kt+P9b2DakZ/FXq
         Vavxmdye0UyLm7M8L9DRNgdnoavDH2WKIWG0PCWryn3wVR1guBcE+lFvzRvnJ/sg9zU1
         rQ1UmubGcQICHqyUEw6QLooZ3lTry/sew+dJOuK/3xCCi3Nv2oBq2p3yMp7milSg2YWT
         YaEaj7mGk4jL1yATOhZlxtxccMIDpIqrnKyDczIuQluKGNUxtDz6k2UTIlDyw5cX51XF
         w2X3ZRS5lIKGXQt5fWJwtt6AdGrzpFKryMqgGd6zqz9Vp8mIbK+wczXelztvUevPhvTn
         EFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nVvMcHxFKWpFeIwQX6rcqpoxp4jR1OruPjaEq0/Db20=;
        fh=7Sf/N6wHSkV6oT3fMv1ByeSkCb9kLzJuov8I8qOIVDI=;
        b=Ewe9SkEQehH+4iv5U//p5y5znomIGXRONiMQ59Odo8LPpmqlfI4rH6JAVz+lSNO6Lf
         5elBGNetrGYRRTpvD+dv445o8E6NoVVYYbmEahuLfSizbTZKGB3NQfrCqeS4HP80NiIr
         4LnMh8Dq84QycmPLXYwLn2CXCXTYmP6rxaWRZr6X2hb+xu7zddcEh225pfOUkh/QSyTI
         x7LmAk0ADiNWlxmMUlv8hCOnp6eZAjtU3pevwYlIXDJV251wpnW0ZgTV19GeODV3dQhU
         ru8xgEhh234cjdEkBM9AIOFeXwSh4jKR0W9TTnYRb7+3Ee4fpWK+nGRabyzlbR41w5Xh
         J1tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606517; x=1769211317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVvMcHxFKWpFeIwQX6rcqpoxp4jR1OruPjaEq0/Db20=;
        b=ergw10f1Pc2N7ULdMKhoN9SRNSWovTAaFryPcvN2Heu5ZuoGH/KoQl1TrLveutgxyM
         STvZv5/rprUM0D0v7v9kpYuE45R3W55AFpuFb179BiUXCUVeHIfMQSoUjGCO5aGoAMGw
         454+7XUYmNNa9aQGW8Jwz1tnBKiHtUySl9O7a6bjyQieEfw3VlHgm/fM5/AAdQazyEE3
         1xCLVNYYwrdHxlqXAAeJ52liADCcQ47jHcU6ErftKIXrdXvLOlrK1BbYMILWYMFK6pdF
         FPZjFpkzbTPbVFyfiDTHqxuUXAB1qse/jOpB0EMoYEaF8tp9poo5O6QkFI0VmKj5/xfX
         n2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl71SntgaKnGUghbB9xoBeliJ8Tt6maWRokD/YgAlFJWebVuHToUM7QcL6D49gMFv4Tu+jxK6a2S30BbUx@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdEVspHabquQFVSUVwPO4qhT/3SgxPLpScyL+LmsFsNz5oLZB
	JhS8noXsDteGk9rcOC0cx8CzdGDQ+by4I+rYX7N2yWB9yB5J+LezIm05r/f3cKOWpxHhjl2BoqZ
	lZRjlwPH/m5wAxi3ORa2DDM6y4AVSbWYEsAVMZheglA==
X-Gm-Gg: AY/fxX5StKw13xQezywzalHEkGhvLPSgd2QAnTuO+rb/o7pWoWwFmCUvrxQVmDvKfz6
	hvbUFyviehBOiVNCuFPX9iQ33KN304Qc7A3m4LDhkDZ49C77RoXaBKNaFDjychAaFLM/INda/EZ
	iBAYrrf7hmBQEVkKUd0RJaaqmh1Z+0HIach4//MiKEAQ0FNXRdhmbgcZWx+EqdRUo4wLzrSL/mx
	Bb0U6bh2NumTqsm7ZfgWTfoPP5epOp4cL4GvvdePNltEnOcOHAT+Q2XbE9jh8ZLuJBflDlZtSkl
	pUFp7d8ajQczaML5WGkGcsBwyIHRvxk9rNbJ8shk2KCxbjNnJbEmDrXoFg==
X-Received: by 2002:a05:690c:ed3:b0:78c:10d6:1e8b with SMTP id
 00721157ae682-793c66fed4cmr36954647b3.26.1768606517669; Fri, 16 Jan 2026
 15:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010030348.it.784-kees@kernel.org> <20251010030610.3032147-3-kees@kernel.org>
 <47a2f0c7-c25f-4734-840b-fdefc2f3c4a9@kernel.org> <aUVIlvOSvobrdrKV@stanley.mountain>
 <bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org>
In-Reply-To: <bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 16 Jan 2026 15:35:06 -0800
X-Gm-Features: AZwV_Qi7IfV4loLjy6_M4Wg9pj-bZgstydRyU-pSfKvInieL_J8lQ-37srUWiOQ
Message-ID: <CACePvbU5Pqo=bw_j8arOq16o1JBOSwPtuMZBVozy4FV7YsSLGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] module: Add compile-time check for embedded NUL characters
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Kees Cook <kees@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-modules@vger.kernel.org, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:59=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Dan, Daniel
>
> On 19/12/2025 13:44, Dan Carpenter wrote:
> > On Fri, Dec 19, 2025 at 01:29:21PM +0100, Matthieu Baerts wrote:
> >> net/mptcp/crypto_test.c:72:1: error: bad integer constant expression
> >> net/mptcp/crypto_test.c:72:1: error: static assertion failed: "MODULE_=
INFO(license, ...) contains embedded NUL byte"
> >> net/mptcp/crypto_test.c:73:1: error: bad integer constant expression
> >> net/mptcp/crypto_test.c:73:1: error: static assertion failed: "MODULE_=
INFO(description, ...) contains embedded NUL byte"
> >
> > There was a fix for that posted.  Let me ping them to see if anyone is
> > planning to send an actual patch.

Should I wait for the actual patch for sparse?

> >
> > https://lore.kernel.org/all/20251211175101.GA3405942@google.com/
>
> Thank you both for your reply! I didn't think about looking at the v1.
>
> I confirm that Sami's patch silences the errors on my side. Thanks!

Thanks for the report.

Chris
