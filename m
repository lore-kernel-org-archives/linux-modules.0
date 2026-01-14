Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B723504B
	for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401460; cv=pass; b=OrJpBedKsPk/iJ0Q5W/UL66sQRUtiMHANDXjBNtxzNrgje3rDb/DPCThVAJv2SjMKDfk0QGp2ylyGn2/8/OkHQBIT+eJvQk4DpmNcL3SV20c5Q6ndZyAn6DAdI2p6nYm/TM3t8FLkN5y3hR7G9RUU4ng/6ZvKInjo6i03Emcn6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401460; c=relaxed/simple;
	bh=+gZtxbzNt43l59bSct2Wxe+p7Zbg0+RNqLubrnVLiPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIAGHUYMV7SVdlSs/J4W69ddeFeupUWzoKRYmLpBNjLHyvvLuh+gFb+8lP7a6otysxdNKpcdPjmqYojiJfTOpQtO/AtkFC7c7nCoh8z/a47vjY9cDwUbGQKkFPiuuCdjbyrIfS3/Cpry0LyDgUUQc9iPBrAX1uJCdLb/Irt13sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSTCbmXI; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSTCbmXI"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b07583340dso560206eec.3
        for <linux-modules@vger.kernel.org>; Wed, 14 Jan 2026 06:37:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768401457; cv=none;
        d=google.com; s=arc-20240605;
        b=CLYgSTS37H0HX81YIoUsE5rgYKv0ZueelVa3691k5ZN8wYGOPJMvGLhg84MkQ6VSDc
         oFWNe/5do2wAkIr5M0hZnT9phBICb17jx7IbbIkF9TKJMUCNachScz33vzc+8lSqKdo8
         7WbN9t0qE+N6UiPaEfbjCX6ICCDuIT5Gytzj4LKCIivAWH2/Jib2bWBnoNIhMCRWmEVX
         0DVoHfPqq/0OyVOkXE6IHduU01lfnPa7oz/1WpDtuz00kf3rM/uhdveFN3S4Je54KdSW
         acjej7kbp0bKD7uRYnJguBKNe/VZbX5HmsbnPu6rAhGyIujYO9+sZyo7RSwP+DLiIarO
         bACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7vz6gsheW2ZkxS8OzJeR0mXOpyBUWqb5nPTzr3eRxHA=;
        fh=yVwl0hLYD4LZhAE39m6elzGjbzKoh0xz7Y64tLWq1jA=;
        b=BUZwBNuMsLHjq2PzBsCKfHGJ6z5Cjj1moE3qL8me388UblZ5HLPiaFum9P1yEbCiYi
         GRpEdcAqxpUms/X1BLPIpd2KK/jRKOK2rjf3uqFdQn8Wh2HAyAm/37B4EKJdHCD+tsh9
         T36wMZaA/4W2e65au2B/60/PUyZND09BNagGGAYjb7suofaeGsZ1qp43GFYHp7EjD7C1
         04iJwmQ4J02JSdUG1jwA6NLwLWz0mODZ9ASV2QktlW3oj7f5kjCKmjCBCkJ+weq54lOj
         e2LZKxCvg8GVYVaKqCkuBmkh1DBP1t/AmCN1N9CI0+XxsROyBBxKoPhzO0QyogpfC5sL
         Epow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768401457; x=1769006257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vz6gsheW2ZkxS8OzJeR0mXOpyBUWqb5nPTzr3eRxHA=;
        b=PSTCbmXIS9PDEip9hvDMjoJTiKDD5GXsYE6yA2I48WNjS3HL9OK7qcw+xbBlu2UY1c
         12OTISbTJlkKpi8fjOa2rj9P4myBU6pfTzCGmDq36+AAyHt5diagpOk5tudBLip/6E62
         AxCHG06frpN/v7DgDuzXtVodn8Qwzzrka9gCpyx/i4KlRfVoLIFkISLGknUnzc45GQWv
         dcf91a37Or7Mt5kXg8bz6Poaj3CrYQABlixOEMjT+oZV2iWiSNWsNnZTVt/MpAVbVIM0
         lzgLhEq6NfVMpIu5DljlX3jh2/oyH6JhGfRg3R9vaxhPaWRg0qeCGckAjqZLjbmO07vf
         ZdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401457; x=1769006257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7vz6gsheW2ZkxS8OzJeR0mXOpyBUWqb5nPTzr3eRxHA=;
        b=YvB/1VUCqo56MVLkcAojZOmOPega0rdS4Z+guJqFPqvvf6XNy97eyldRmHgCKWPiUF
         tRQagJ4fIhSCrLram4KKOP+XZvvIm5cT9b/oB00HbIqex+hgOnO4QKJxwN/KuI+lcjoR
         JUrQmGnedyWhpT+bTDkreqtyxUd0Xa3aX69OWcPhvfc94M+w8WWdKsly5AK+LznOLhE2
         +TI1fzTHLIjPTX13kjAsWax2Wrj0erNoPT1Mww1/sSg7+wh5oFLFxj9PYC7YViywefQ2
         lT5hkf1y+jS3GEuWvnaAshtf05oHxJr76N4WCdAeVlhH5POvO+fe81XBddJmgzslVyKh
         OC2A==
X-Forwarded-Encrypted: i=1; AJvYcCWnXvI2CdLCpXk52QCby2nA06nSB/ztjFvhVPz1StxTJ25phnn8v0raZEWv5EhXlplWHsvuHmEkRg3MFjyl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cOokSnpyMkM8pQif6xRoecLFSpYxtAesgkguZ+JEEclWoHz+
	j1CaeJp8iLF1WjbBIjtfiHOgHaKA6oXjk3boedWjkOb4sQC6CeV/+WVdkwpjDcG87JvlNShwKJN
	roBPAJ03XfytTWxMGTNa9i6WLx7ByHP4=
X-Gm-Gg: AY/fxX7BjjIxRX2kf50J4OFmlqQqQKy8Ubc02XwteQahxu4FCCkn8T7frmJd3IG3JSj
	xqWxcsASj1HwcnNyYLqaQO2Gdz6vHrhEhpCLAAN7MA3QoiQ9pRyDQI4EjG1838zKA4LQ6EUAkIe
	F3RAeuq/xnGs1l1cGe6MINRamxFOcB8pSsM2rhiCeQxeYkzWn/1BeGs/HVxtXKeVRx5/45129PY
	bwxn/iKbNLLxpcAx4V2pvAEoeaVbqCyD3/qmXf1tybn41cvrXuzPHgt0YBHM92NKNxzh9d1ItgU
	rx1KBcOiWCM1uiCUewPvexS/rc4FWiJH2SThn6rjeDStsLyi3aQK/XWh4W0rlRMOANoi2xCDrzr
	quvkZMk1eS71EpeH78PEPvts=
X-Received: by 2002:a05:7300:d505:b0:2ae:5b23:1601 with SMTP id
 5a478bee46e88-2b48662c38emr1719555eec.0.1768401457031; Wed, 14 Jan 2026
 06:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
In-Reply-To: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Jan 2026 15:37:24 +0100
X-Gm-Features: AZwV_QhGm6AQT1y-6rFZieo-Sg-jU4esKv1Zq0TRBf1aujTPmnHrtNeDeXDpT-o
Message-ID: <CANiq72m7S5aK22yzeGykGH2zhvL_UrTE2jxf2-6Fx_8oWR=nPQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 00/15] rust: Reimplement ThisModule to fix
 ownership problems
To: Kari Argillander <kari.argillander@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Youseok Yang <ileixe@gmail.com>, Yuheng Su <gipsyh.icu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 4:09=E2=80=AFPM Kari Argillander
<kari.argillander@gmail.com> wrote:
>
> So currently we have problem that we are not always filling .owner field
> example for file_operations. I think we can enable const_refs_to_static
> already as that is in 1.78 and is stable in 1.83. So that fits perfecly
> for us.  This also seems to be quite request feature but I did not found
> that no one has ever suggested that we just enable this.

For context, we have been tracking that feature (as well as
`const_mut_refs`) precisely for `THIS_MODULE`:

    https://github.com/Rust-for-Linux/linux/issues/2

There is also a test that Ralf added upstream back then:

    https://github.com/rust-lang/rust/blob/main/tests/ui/consts/const-ref-t=
o-static-linux-vtable.rs

(Not sure what you mean by "quite request" though)

Cheers,
Miguel
