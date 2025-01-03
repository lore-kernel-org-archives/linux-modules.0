Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D374C79
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735863903; cv=none; b=b0wZJUfKOsKcIYBmtXTsRk5zeD2r17O0W7psMBnZ53sm6NLDtzuVYpMgd7ZrZOAdF9X/cNH525+3fIBExIfHNdS/wO6w5qr715Il4wr7NoJcirCVy26+RukkmwGgQJL25aTYa2/I8153xNE1VjoWw3lJaiJoCqC0lY8Hb1aCMWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735863903; c=relaxed/simple;
	bh=JZYO9PPavHcBEPWGuTcvM+j/t3gJIxWN7YL4o4FoqJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb07bWIM4ieB7hE509wCo0+EXVpyKPLaevHa/Jimti4U99jQ1NO1RbJuJTKfP8tNxYKQA+857TI3ho0zxBAIT5z7ljS7F57HLBNTggMXHF+qXze9vbkh6+PDu/AHvhgvpWmJYD0FkpqMxFQvpz/VN+pSqjD0w8/jVZxhvvbWfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmSsE/TM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmSsE/TM"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so3220a12.0
        for <linux-modules@vger.kernel.org>; Thu, 02 Jan 2025 16:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735863900; x=1736468700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNzpgmoCzAwb514bhoD5BPCvyAJMbaE9RvBKoPbv384=;
        b=xmSsE/TMQR2PPor0CkR/mv6aFFeqREMHN+4CgmGqwSsHXw/dbmV+EqF5TeX0CII+Mr
         K+KOka0ODyp/Q6onQCvVj5msBb8p+BEFw5VRTYIleZLl9gXmCO9egWJWcogGueOxR41R
         DSXwb7eYmA40PvPqhbWuAY2gGsJSfGzm4/5NyH9m0P+zdcGLmAW7MyiILWQouQCkC2VW
         nS1mb4BaVP6qJXta0mDbwnI9XoDAwMpETa5mx1szi5eUtqE1ormRKa42pfxMHtWds8x5
         BIj8wUkLfEtSAZM+T0zAbThaTGeIbcuFpnc+yMCn5e2aRmXK4hv6z/qyq/Qf3WQSWzD4
         zXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735863900; x=1736468700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNzpgmoCzAwb514bhoD5BPCvyAJMbaE9RvBKoPbv384=;
        b=fmXBcvxPyW9NDfo5ApK1IX9Sp4uWGtrGIVgInpQpBytJ2Brg0rHG5yfM7qsZ4IY1Yf
         3HcMyp72zZW/UYlRdgxmXXHQ9eg9StWbssBjKWY9oRAVmaA3VN1MvgbqNXnt8t70cHAG
         u2VDlItaQ+JCkQpkTrNuOhMpP9Mpg6o14TjL5ZslK3Hm0fa1Cb4lsJ0ddPET0oz/jKmG
         NxP3uYHmI4XEG4WUCrc2UuHtBfEwXGBdIosOWy5LI7cl/EvNDfp3aWC3ZE0Me5NjHQEX
         egTNAvxu5pFT0F865qHAiI6P83S8XPnu4QvZ0YQewuJqs/3XBpv5jxz3UDlp99H48Xgf
         mB5g==
X-Forwarded-Encrypted: i=1; AJvYcCWLwGmqFxaZFO0N9i24q/1j7xlaJHYZGJq4AZhtABI0X66Zv6N0l9PueWgkIOLjS/EEW9qr7BqCF+WgMxct@vger.kernel.org
X-Gm-Message-State: AOJu0YwDj6qJDS64RIcb0SeaNOs+7zxMOF1Sb6Uop6OBy5ocy5MtoVRO
	7u+acBME1JNOYtybj2nVqqSh9ROZwhKjM4MerHAuNdHN1lTpefhF9I58bRVBTcUry4mPWELxSha
	oZzGdoJNZ1ghTcow/EI9RGb2hAiJt9dJYQnHg
X-Gm-Gg: ASbGncuNLOYgSNK4ptQf3Jvpie0ziORcxk+amWK+mwb5daqbKFGd5xzAQplhnPxyrhT
	h/GU/zdrU3KWceDD58YgsfcBXuFLFBXKnldY=
X-Google-Smtp-Source: AGHT+IGQAbpr8horQ2fysiJ3MPMS+mcd+xtgrtyaVmH+uGzcUwbPEeJQouzoojRERX+UqkPJPlPOptSJ/ishqBAiBkI=
X-Received: by 2002:a50:8712:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5d917875c13mr5922a12.1.1735863899573; Thu, 02 Jan 2025 16:24:59
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-29-bigeasy@linutronix.de> <20241230185812429-0800.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20241230185812429-0800.eberman@hu-eberman-lv.qualcomm.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 2 Jan 2025 16:24:22 -0800
X-Gm-Features: AbW1kvaRDs2xYpGZgla1RZEmBOvM7PAkjYw9im4dG5fjLKcfN-MGKXe4WhweCw4
Message-ID: <CABCJKucZKvFcTQEqbKNUfdYv-upxsH6cmw1=iHUORPFJc+vKHQ@mail.gmail.com>
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

Hi Elliot,

On Mon, Dec 30, 2024 at 7:33=E2=80=AFPM Elliot Berman
<elliot.berman@oss.qualcomm.com> wrote:
>
> On Fri, Dec 20, 2024 at 06:41:42PM +0100, Sebastian Andrzej Siewior wrote=
:
> > __module_address() can be invoked within a RCU section, there is no
> > requirement to have preemption disabled.
> >
> > I'm not sure if using rcu_read_lock() will introduce the regression tha=
t
> > has been fixed in commit 14c4c8e41511a ("cfi: Use
> > rcu_read_{un}lock_sched_notrace").
> >
>
> You can replace the rcu_read_lock_sched_notrace() with guard(rcu)().
> Regular rcu lock doesn't generate function traces, so the recursive loop
> isn't possible.
>
> I've tested:
>  - the current kernel (no recursive loop)
>  - Revert back to rcu_read_lock_sched() (fails)

Which kernel version did you test? I assume something pre-KCFI as
arm64 doesn't use this code since v6.1.

>  - Your series as-is (no recurisve loop)

Note that this patch only adds a comment to is_module_cfi_trap(), so I
wouldn't expect a functional change.

Sami
