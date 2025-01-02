Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99C943173
	for <linux-modules@vger.kernel.org>; Thu,  2 Jan 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735862399; cv=none; b=sUjKcEi/GjuhbytHKFIdFuo43bGHmihZvzBYMcsTf4iklr17Tit0wYP8dlkejoTHn2HS+LCEPb8/awOnOQyHSxB+Zt0cjgHHeQBlo+YlRG03z2Jhc9f0Q+/eIDmoap22XxFnGMhXpKdP6MgrS86QVcFCLQFLO926XQq77qInZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735862399; c=relaxed/simple;
	bh=HxNd0naXzljiSFG6AXRAjPLoLBglpIzBtZ51c35EOYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv7hniluqmozJ4CzQPKF1Ceo29WDGcxf4NBpvqA8TuqnB1xukoEPajZwaI2DHj95FT0xgKoR/0WG8upLXLyu6bo/wfJy9ewq/ePZShhCMn6Qzmpsji39HYXRiJJI3dFtgd1Y72sHyMRGze32b8GoAdNJaknPyxIJa0ZWgrl4nrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYB9C/FK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYB9C/FK"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so3078a12.0
        for <linux-modules@vger.kernel.org>; Thu, 02 Jan 2025 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735862396; x=1736467196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JagMMKgqgxjUnOD8y3ma7xr4mL+1z6Rr/CnmbvmVVFI=;
        b=eYB9C/FKO3+EaAWckBYYYzsksjCW8UVx1gLXdzx+g3/6V877s9V5Cw49WEFtH4jwzh
         +kN+O3AKu6OpEBR0K41uguZhzOhDNjT1dVja+HgUu6lUOEtAGz+CoEDMA1xvpw0M8n+W
         fYE4qbl0QJSBhu/Y5OwG8F9IGmKRjVvxhqiZntM63J9Z7ei7OixSVjUGfESDd+QJpdkd
         r3iUD9CslXFvYeadtYk3cDqr4bRV3I/OLO3uluJ5z6MlIp1upEuGV8LxqeWu4fgYlhMB
         Ly+OYiMXAdY/TPcXzsxIr9Nbs/JZg1T9CwCYFGzoJXAByx3MZZu2z7FTzi6b66VNsiaT
         wauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735862396; x=1736467196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JagMMKgqgxjUnOD8y3ma7xr4mL+1z6Rr/CnmbvmVVFI=;
        b=noqJqZDq/YjZpkp+motwlS5+L4pmHNA8/43stoNnB5FFyipRpViXmghmTjkvmuW470
         4L+4bDdMoDl2A6UK8BUH09wyM34itVrXUf88Tfb/auJ1tlm2kIIgabT4EzPFdItTodOe
         IK55QAsUDpX2x7RHjtb7mvrvlKCPIfzL2ub5gXef2rSvTBjKExA96PsrZok/ZGIo5PmL
         IHKCrSLbNmKOmMOt9v2J5ZKFNoxl2vIHFsgqZnNhcOjZWbzO6iGz0Tqd4KMVQmMJHrxu
         7CLHEnqp17O7aJXZejz3yZlLK9QNeGj1aZxU6K4ft6STUDRzWT5xrGKrNnp3Y45a3riF
         U9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNdN9RPKwJ273oDjZ4lnoJMD9bbgxSd8liEJozacWWbIKBp5nV4XQIkfJXyBgWslkOOSgsenGUVxpIsdjz@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+8LbBlPFghvuLXrMeEPYMqclGVQneH/ipmYIZzUKQW0LXtHl
	mBoN3JsdVgn2sg2Eq/g2qbhzW9P8GL+27Lodv3OdFt6owzETFlAdAU1DJPmq4a79k12a3F/8YcF
	SYq6efIcrqj1TWvn27+klWvY0SzLfqDPg54AA
X-Gm-Gg: ASbGncuhw8jZfVDd3vfu5PBD8kZc1Mifm5Vh9p6FUAyV3ZE4rZwTF1mxvecJgN4r2Pr
	1km31H4qp07B+sdpaxOTh9AO2gDFedwzw+4Y=
X-Google-Smtp-Source: AGHT+IG4Bcn/HMWEbZ60oA6s5HIWBq/XoUKm5KwR7Ob6SU5lDVTpFL2Mtv8Jau8vEkr2GAklzWbdBN6Bor1xnBZs0DQ=
X-Received: by 2002:a50:8712:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5d917875c13mr4393a12.1.1735862395849; Thu, 02 Jan 2025 15:59:55
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de> <24b66f6c-b8db-4f2d-bd46-e4417cda7ef7@suse.com>
In-Reply-To: <24b66f6c-b8db-4f2d-bd46-e4417cda7ef7@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 2 Jan 2025 15:59:18 -0800
X-Gm-Features: AbW1kvYVjQDWyArYdrMXKgW1eNU6eIYHxn2KN8D2TEatAw19qC0_NMyaHZ2iZSc
Message-ID: <CABCJKudYd9HiOX=d9ghVB+v37JEPJoKX_XHyopF=S7FYFabQSQ@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Elliot Berman <quic_eberman@quicinc.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Mon, Dec 30, 2024 at 1:13=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 12/20/24 18:41, Sebastian Andrzej Siewior wrote:
> > __module_address() can be invoked within a RCU section, there is no
> > requirement to have preemption disabled.
> >
> > I'm not sure if using rcu_read_lock() will introduce the regression tha=
t
> > has been fixed in commit 14c4c8e41511a ("cfi: Use
> > rcu_read_{un}lock_sched_notrace").
> >
> > Cc: Elliot Berman <quic_eberman@quicinc.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/cfi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/cfi.c b/kernel/cfi.c
> > index 08caad7767176..c8f2b5a51b2e6 100644
> > --- a/kernel/cfi.c
> > +++ b/kernel/cfi.c
> > @@ -71,6 +71,10 @@ static bool is_module_cfi_trap(unsigned long addr)
> >       struct module *mod;
> >       bool found =3D false;
> >
> > +     /*
> > +      * XXX this could be RCU protected but would it introcude the reg=
ression
> > +      * fixed in 14c4c8e41511a ("cfi: Use rcu_read_{un}lock_sched_notr=
ace")
> > +      */
> >       rcu_read_lock_sched_notrace();
> >
> >       mod =3D __module_address(addr);
>
> I think that since 89245600941e ("cfi: Switch to -fsanitize=3Dkcfi"), thi=
s
> can be a call to rcu_read_lock_sched(), or in your case rcu_read_lock().
> The recursive case where __cfi_slowpath_diag() could end up calling
> itself is no longer present, as all that logic is gone. I then don't see
> another reason this should use the notrace variant.
>
> @Sami, could you please confirm this?

Switching is_module_cfi_trap() to use rcu_read_lock() in this series
should be fine. KCFI checks don't perform function calls, so there's
no risk of recursion, and this function is only called during the
error handling path.

Sami
