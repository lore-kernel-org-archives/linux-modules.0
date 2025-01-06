Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078721DF983
	for <linux-modules@vger.kernel.org>; Mon,  6 Jan 2025 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736198708; cv=none; b=Yoig6Y5kku3KRZtDYPx0y1fMb//+ieHb55paDP/vm5J7CqrWXIzKY35N6hfiXSfp6GEc5iTU9bAm/UhlHTQA8XCits71L4B3DLqQxc66RejlRho3Re6a3YeLIWzPtQPvIHYqyeZVTXz11NSAGDrbrttFzyoDp+riM5DyLTtRDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736198708; c=relaxed/simple;
	bh=p4J4PAy2tYWT7PoePXeGlsHxjWsDWfXEDLRMS94pf48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lxc6fQtTPJPgFsJym29A7dbgra3sQ7gQl9NwcIPkcXjJyFSSsssuy+kCnFnQNvJPM/RX5GCL1ep1o++aO3mPUW1/uCdiJkxUJjVf46BGhzlQ40Re7k5B4WbcUAbC8v0eS3Cmbj6cYxajUltFqFnLvoppfFFsfI2vT66oqhE6c28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=um8vT7dd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="um8vT7dd"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so456a12.1
        for <linux-modules@vger.kernel.org>; Mon, 06 Jan 2025 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736198705; x=1736803505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln1xgM2oStVuWhoEQmusatYJbTnshkZKwHgkCtpswhE=;
        b=um8vT7ddJVPiZ63UO3lGMFwVf9n2hmCe+9qWi7EgzMNd2fw5gJCDd3w2bOlo/XmXCA
         AS80tkdMJchFSrh1GGx1+G935B38Sa6b8t/FxVWxgOS100E2HvDd5VgM/M6N+W0xLQ1X
         fLvsXKkvOrxgGwSECY/sSFgn/R/j4zjp7teTk9JMMjQ0e0bYsXxK1qzygASFf5Sczijr
         +vjZXJfcub26+3CyXQ/maJQG3RALa4kWYrCXq0W6HCuyxZWK0TG43YJEC1thy1jEzNVY
         ifFXolyBjlkCDu/ox5YTLZtcHUEYBUirhf2CPn9FTmTrw4RcQ3i0D0z1Usv7R64K7TTe
         qP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736198705; x=1736803505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln1xgM2oStVuWhoEQmusatYJbTnshkZKwHgkCtpswhE=;
        b=UXE4wx8kTc4MFC/2YJY1/UiRRaJELz9lmYjLZUeFIIxf7vz9kCemKIYhWXUasETLyP
         zlA3wKjozy6MeNDJF7rrLYaTWX9UhIYqA7p2LRLwBsj4LwHC6MPZ3LkpQhzoch+SGf1i
         N17PMsvsUhul71Z1oaXGqtCpIPM2wl4qDRtkTQX3EB9huBkeYBD0HJCIBj9uzhGrNtG1
         uxjeLaJhUY+V9LXJgxVMyeXV99kOi2NFkLl1oKSKf0OOg5Il9OflBgIjxrgvewMYD0is
         IpdPDiQbgbiEjaBpQoIZoLrkLCu2OL73xq+w+VwEmF76g+WHijoboDeTUG6n2+Uhfqn/
         ZtGg==
X-Forwarded-Encrypted: i=1; AJvYcCX1gWT0P9UP7SvH9D8u5cU73Md/z05oUk6ruZNw+zZNFpc9LcyxcmipX41wDBPcs+PqIy8+MHvjqsg/iez7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5LxP67A+mv9L11D8PfVfhyghAxuRlrKnn2uhbemXnvfAlHt8
	/KGNBazGfwNpbl6mwRYdz8D3j2D4vCmRstu+vfHIvN4+B9KHBrNIhZhHeyxCXe6cmwvHGVBw2sw
	wlo878sLE4/7GNJKQ9IwDbCvoWP0WdIWTWlV+
X-Gm-Gg: ASbGncuKf3wiyTfHfq7bfvw3AyTALGK9NXwceREt901zpcUG+m64dTHiLzJqUyEsiEr
	dw5XGWPLd/HdidpjPS0NapkzUbqH1Ix/iZ94=
X-Google-Smtp-Source: AGHT+IH41nFR4XjznMl40Um9p1ogmkX1bwJtAiR7xoIgiSg+CzLikN/2L1bWntFHz6ID5Nht/Mau7+LGgOJyS3n7MqI=
X-Received: by 2002:a50:9f67:0:b0:5d0:84a6:f1a1 with SMTP id
 4fb4d7f45d1cf-5d95fd9ba7emr16336a12.6.1736198705050; Mon, 06 Jan 2025
 13:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de> <20241230185812429-0800.eberman@hu-eberman-lv.qualcomm.com>
 <CABCJKucZKvFcTQEqbKNUfdYv-upxsH6cmw1=iHUORPFJc+vKHQ@mail.gmail.com> <20250103101357180-0800.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20250103101357180-0800.eberman@hu-eberman-lv.qualcomm.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 6 Jan 2025 13:24:28 -0800
X-Gm-Features: AbW1kvaJo1nyTcxgxrH-hOUFMC8ycywlnsAQAeEU4OUg47oM9mviVzwMlb8sMhs
Message-ID: <CABCJKucPR7ty7oPn1NYkJidv_Mk46+E0B0vmGhBXz4Stt+vujA@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] cfi: Use RCU while invoking __module_address().
To: Elliot Berman <elliot.berman@oss.qualcomm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Elliot Berman <quic_eberman@quicinc.com>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 6, 2025 at 10:00=E2=80=AFAM Elliot Berman
<elliot.berman@oss.qualcomm.com> wrote:
>
> On Thu, Jan 02, 2025 at 04:24:22PM -0800, Sami Tolvanen wrote:
> > Hi Elliot,
> >
> > On Mon, Dec 30, 2024 at 7:33=E2=80=AFPM Elliot Berman
> > <elliot.berman@oss.qualcomm.com> wrote:
> > >
> > > On Fri, Dec 20, 2024 at 06:41:42PM +0100, Sebastian Andrzej Siewior w=
rote:
> > > > __module_address() can be invoked within a RCU section, there is no
> > > > requirement to have preemption disabled.
> > > >
> > > > I'm not sure if using rcu_read_lock() will introduce the regression=
 that
> > > > has been fixed in commit 14c4c8e41511a ("cfi: Use
> > > > rcu_read_{un}lock_sched_notrace").
> > > >
> > >
> > > You can replace the rcu_read_lock_sched_notrace() with guard(rcu)().
> > > Regular rcu lock doesn't generate function traces, so the recursive l=
oop
> > > isn't possible.
> > >
> > > I've tested:
> > >  - the current kernel (no recursive loop)
> > >  - Revert back to rcu_read_lock_sched() (fails)
> >
> > Which kernel version did you test? I assume something pre-KCFI as
> > arm64 doesn't use this code since v6.1.
> >
>
> Ah, thanks for calling me out. I dug a bit more, I thought I was looking
> at a recursive loop in the ftrace buffers, but was actually the expected
> behavior. When I tested on the other configurations, the stm dummy
> driver hadn't kicked in yet by the time I looked at the ftrace. Indeed,
> this function code is not used on arm64.
>
> I experimented with an x86 build as well and I was able to get the hang
> I remember seeing after some tweaks to force a CFI failure. Still,
> guard(rcu)() is okay by me :)

OK, great. That makes sense. Thanks for taking the time to test this!

Sami
