Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A693DE457
	for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268113; cv=none; b=Oasn3YVFNqQIf6byeoGt2qRK/rSTB20qMqbDunHVmJu3SW4ObB3QfUh8inwe5XAohyaLTr1QnuCDwyNgLoysGF0GAFz7TeTdm7MpUP5AlKlUNMhNrS2HJaHSF21WGUXbpmxOVrUhBosY9KBcKVwScorG7rePaq3O5zTLcBwqazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268113; c=relaxed/simple;
	bh=LMYu57gU8RUYV0LQ5OTarh15mKTlnPD1JC7e6c9SqXU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bb+8fv5SpbHbepewQaZr/gEDsW+nZ18OMuXQL9U6+9AK1YkfSsU87frSL9crkCEvplIZ4pXReqhpJW6+dguEmxCKB1qnf2prfcSsbAlgWAN2jXdcDfMmmLbKxiHPfoRS27tDUGUXrimLbVFKSKHf13Lp8i/khgcK+eITnNPqiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=MZcSB/7k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="MZcSB/7k"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b3e03939so8119195e9.1
        for <linux-modules@vger.kernel.org>; Fri, 12 Jun 2026 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781268110; x=1781872910; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMYu57gU8RUYV0LQ5OTarh15mKTlnPD1JC7e6c9SqXU=;
        b=MZcSB/7kLPyZuLn+TWmZsVGRt3CiWJg+vvYCE+2nLVS9a/ac7q8hRMMZpcr5BJpECe
         indVjCCLUa6Dv03RYAHD4bXt1C8pc3mHOVVmTUpt7V4ea3WB06g9ivsPnyjZ88U7tVrW
         NQw3SJTJNZKgxuohoQDhWtnuomygckypLo7Z2GxYCrm7CgvN/e8PNjkPy0itiQc9nvQF
         H4qhtw2Daka/P6OaUhZzcnjnnEhJ9lTE2St1EYo8unxwbZ/SJes4QUJj362sSUlobgt/
         pIn7QGLhtTjy0P5LZARh8ryMwlVkaLL12Qa/rHMXOgPtJJ2tAXKBp5wBsTbj4Zp/oR7J
         jRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268110; x=1781872910;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMYu57gU8RUYV0LQ5OTarh15mKTlnPD1JC7e6c9SqXU=;
        b=oOFNRRrpo8Xbi3C7kO+OUBfuxnstYyECjzuR81MRpEB7XcJxuBGiy/+i1AV6wyMt1E
         weQrUDzBphkZxhzf5gwYTNnXtw6Wnx6j/RXSimvFtt8ZTjUCL74fZ/qxQXS6y572nGzB
         pC9lYoxMngYhvf+eOvca57QOTey9RGHCM6P9yEdv7YZMQ8m3G2J0sXBiJJiklHaPqyFS
         hne4tan9ZOY91VYgU22FlaBqOYQUHeSJMXi4JyLp7x0aQaubAfS7hz5Jot5zD9b3gvAO
         RuIGMk2WaCubg9m/eV4HFzmRFMPTnPUjevYtGnK5kLMyTyC3owbgAyuGBjyuv+AdRBD+
         Hl/g==
X-Forwarded-Encrypted: i=1; AFNElJ9u1ERXWROSwfQXXL5G2Jib6jRYBYvw5kcjhHDnfTGMRlvqJYZhdFeLFZQcFC0kZSP9N2YDhe9a6k2ybt3F@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEnFm9b4NwhYUA3tZGGneKXgQ6Y0q3W/RxqwaxqrGH+qLaH6a
	BLoREaz8GxSHHNLNMwIF3pYGcOnNYhA0u5UDuMhkgjU8HjVcSvw4FIL+RaGhZXHhMA==
X-Gm-Gg: Acq92OFnwVfRbAhrfD0krWoDWmslo4xomvfG/SY68DccWv32iqQqyyvlWAesDcUha+A
	WcoeAhPgIhRDTUIVbjtDtFAqB0BnmAGmiYpdJLw8/hp7m9rzTGT3jqVzZfcklMzWc0eVhUfuQvy
	z8ju47a7GOYdaPwUG1xMyJSCyr3kRpG8cjpfK5NvwyCmpEn0dUKHWFiqfmfNcrY2PWi9lKGtDhJ
	3PxksYtx8Z1uSo5+oS/2tbV7+RMR+Z26m3DcLubu+dMcpMcCXnEqyMGsjwpKzdq5jWNGD+/kEfr
	v6Kh/am+vbW65rZFz55aaA7GoR+qoiCWy8EE5G7AmnE5ycs0uoVB7Pp06xtxu0hAhNvR729kXwV
	S0cUOa2l8SMB9qVuzJkRxhvDu3KtuKvEXCpM5jIoZeAYyoeTE9mThNO6Ww+ef2+cjAk7Npuflnb
	PResGkyl0g3rzU/ZlpzDKazRnjwx21PJo=
X-Received: by 2002:a05:600c:8b2a:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490ec50a338mr30469575e9.11.1781268109862;
        Fri, 12 Jun 2026 05:41:49 -0700 (PDT)
Received: from localhost ([185.213.155.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c08fcsm72043615e9.1.2026.06.12.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 14:41:47 +0200
Message-Id: <DJ72UFZFSASR.27NR1EMT3MCTJ@9elements.com>
Cc: "Michal Gorlas" <michal.gorlas@9elements.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>,
 "Daniel Gomez" <da.gomez@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 0/2] module: restrict module auto-loading to privileged
 users
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: "Kees Cook" <kees@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>
X-Mailer: aerc 0.21.0
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
 <20260605183646.GC2939956@google.com> <202606101317.D23383F465@keescook>
In-Reply-To: <202606101317.D23383F465@keescook>

On Wed Jun 10, 2026 at 10:23 PM CEST, Kees Cook wrote:
> On Fri, Jun 05, 2026 at 06:36:46PM +0000, Sami Tolvanen wrote:
>> On Fri, May 15, 2026 at 07:20:18PM +0200, Michal Gorlas wrote:
>> > Add option to restrict the module auto-loading to CAP_SYS_ADMIN.
>> > This is heavily inspired by CONFIG_GRKERNSEC_MODHARDEN of the latest
>> > available Grsecurity patches [1]. Instead of checking whether the
>> > callers' UID is 0, check whether the calling process has CAP_SYS_ADMIN=
.
>> > The reasoning here is that many modules are autoloaded by systemd
>> > services which are running as privileged users, but do not have UID 0.
>> > While systemd-udevd runs as root, systemd-network (which often
>> > auto-loads a module) for example runs as system user (UID range 6 to
>> > 999).
>> >=20
>> > When enabled, reduces attack surface where unprivileged users can trig=
ger
>> > vulnerable module to be auto-loaded, to then exploit it. Recent LPEs
>> > (CopyFail [3], DirtyFrag [4]) for example, would have been mitigated
>> > with this option enabled as long as the vulnerable modules are not bui=
lt-in
>> > (or already loaded at the point of running the exploit).=20
>>=20
>> This sounds potentially useful as an optional feature. Kees, you've
>> looked at grsec features in the past, do you have any thoughts about
>> this?
>
> This doesn't really look like GRKERNSEC_MODHARDEN to me? In that
> feature, the credentials of the usermode helper are passed down so that
> udev or whatever can examine them and make choices (instead of seeing
> the uid-0 usermode helper credentials).

It is based on a part of GRKERNSEC_MODHARDEN policy check in=20
____request_module in [1]. By no means it reasembles the full
feature. Very similar check was proposed for linux-hardened
tree few years back (with the difference of checking for=20
CAP_SYS_MODULE) [2].

>
> This looks like it is just doing a request-time policy check, but that's
> already covered by the security_kernel_module_request() call immediately
> before the proposed module_autoload_restrict check.
>
> Also note that module loading is _already_ controlled by CAP_SYS_MODULE,
> not uid 0 nor CAP_SYS_ADMIN.
>
> Sashiko has similar feedback, and some other notes too:
> https://sashiko.dev/#/patchset/20260515-autoload_restrict-v1-0-40b7c03ddd=
04%409elements.com

My understanding is that CAP_SYS_MODULE is for processes that are=20
using load/unload directly (i.e. by doing init_module/delete_module=20
syscall), and the kmod's__request_module, is a user mode call=20
(at least that's what the comment in __request_module suggests),
so CAP_SYS_MODULE does not have to be set for processes that are=20
just using __request_module. One example of this is systemd-networkd=20
(there are probably more but that's one that I tested), i.e. it will
trigger the module autoload even though its not given CAP_SYS_MODULE.
Please correct me if I am wrong here.

>
> I'm not clear what problem this patch is trying to solve?

To have an option to completely disable module auto-loading for
non-root in general. By root here I also think of system users so
UID 1-999 [3] (had typo in cover for the patch, sorry for that).
Not sure if this is a best approach, it could be also implemented
as small LSM hook on security_kernel_module_request() (just a thought
after you mentioned it). Either way, the idea is to limit the=20
auto-loading, not direct loading.=20

[1] - https://github.com/minipli/linux-grsec/blob/v4.9.24-grsec/kernel/kmod=
.c#L153
[2] - https://github.com/anthraxx/linux-hardened/pull/23
[3] - https://systemd.io/UIDS-GIDS/

Best,
Michal
