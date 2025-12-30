Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DE1DDC2B
	for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103968; cv=none; b=XdGZJg5C9VPda5MidK0UatzSQjO6Gav18QIqc9pJL6ODNSblGpegv1fKyPnaeKkbPVDoYTeM8yCc7hJFICDZrHsFfH60qhRsAxOT8YO+1TnyHGnxbRDIRvTv5/E4gJ8QLWRFKvJLubtTo95CYFUKs5JOoHkH6Kru9IcHjbUF7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103968; c=relaxed/simple;
	bh=8fHyW/Ti4zAza9adcbyQaRbJEdxoFUhmiWRIaEAI3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eA4WbaA1Gzpt+BvPtvfhoml3sQcNUBFI+ttd2tguiv9WtB7E+LzG+Utbt4clgeRcPcuxu/fFp8aTiRm6GlY96GwYmgnI4kYu+4qA12FQak+Ed1zvFnPWbaUvKRsXxxX7k6dxWkm0QnU05bTBf/2L7ovpVV/1tc+bRNpNs2kn5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh9AdfgY; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh9AdfgY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78f89501423so113666207b3.1
        for <linux-modules@vger.kernel.org>; Tue, 30 Dec 2025 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767103966; x=1767708766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw0rUmD4sTrIxkgrINNUcSHVW2jZ3z1T7XxFrwVbvsk=;
        b=gh9AdfgY2JrjWvPrsIaUfOrDd7CL6bZ0TShoOnW1W/ZVldmF9vT9u87bOvErDMgEhQ
         6FcnrSsIGSHcD0vNQP6lYOav5G+euPyu63d9XDdBI64yq80gbLL/oZfXzS6AmWjPmqq2
         N2Y3QLUooi/sXB5OfZj3U0aBAiX+kF0xt7w2ZB6P/8F38Pwouk3KIRaROLtwt5IBwV0C
         PAnGiRMoi8slbTnYjk5UYJm1/joTHEM+e9CvFxmk21A63fwb1T4woikTVdDNsaIe87zs
         i/+lVkyFQg/As43Lpj6R6Tay0/iqXDdkgN0u52sGZtZESA14ZJqwNYDWmN0OReos5xph
         XRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767103966; x=1767708766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vw0rUmD4sTrIxkgrINNUcSHVW2jZ3z1T7XxFrwVbvsk=;
        b=psbwXkec50ucvZWgGSBZT4aOz7BQKrVBZbAhUu5XWCYZ/gDXyo5qef3nhBaoaJ2ziR
         eQjPGbjD3LRO1XPTOQs9N4XjvVwJrIf5Oo4PQvytYO8gcxmzTQ+iYXuiM7mjCmbG1AbO
         LlU8yH+V5G9Ghc0tBnc2gs76027kkXxboxiiMFE6uTgo2H6Fv5dbrs/O6k9XL6wZU2bW
         bXb33KBfDoad+Vxz2gaA7j117zn8w6PVDImxDVG/oUQWb+N/AroZpWzZ5HHnorDI1MrH
         qia8EtJzA4zmib2YrlzkQYKo98VvqmlOK6rBKLv7uxbhbErdqXYSO9b9BzfmFn7YeU14
         LNLw==
X-Forwarded-Encrypted: i=1; AJvYcCVZLlG9PWSD1PUEOuSVMZsrizhl1W71YJCLFD4Sefrw+CmwJVuGlN6q1U2bQJHRPO0DLuwJO8lJYg1sGa+o@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3n3Wqj6PDnZenD5cJ5asxxH9cMMA3eIBIqzu0qOSSj5bf1rDP
	/P4cJsUZrGITIxSWoDyDsGhYmZ5QvJVe0jHyndV36Yy6w7Bwgk9IdjrDub1o3Gw4gkU6rE3IWZO
	8e2L9qZQ3acq0ae0MwW8LJDvbRFbO2TlRgZGl
X-Gm-Gg: AY/fxX7ccW78E4e2djhK88Nttj+5MUylZyOZGJibd0mo8TdlcXD6wpKMUyph3S15ERT
	seSR7QPyQGDh4F5cH41GN/nCXNvOLrMEUJ5QFdF4218KGnuxb3G52XMBLa3vVVxqykRtcle+Ivu
	+5kxb/N31aOR0mAhZxuhtrDPfUQPfeqTlyaQwTF3CWCJY8XtrswMOgeVs65ct67m4tRP04G2RJM
	EPhEECBg/tzkb1EuXadS+fEj8or7OiNXLk1U9lf1sipCxHZqBcLkn+YW/jP003E/PVrmyEsUeq7
	rBZHIPE=
X-Google-Smtp-Source: AGHT+IEoYfeCP1ZZv1nKo1yA/OrpocPbZSb2Qv1jWTQ4AjnbVG3FJHd7cwvHfHGtX4PySl/7ZMjLcE1VxFCFbkVx3W0=
X-Received: by 2002:a05:690e:12ce:b0:646:8ae1:f92a with SMTP id
 956f58d0204a3-6468ae1fa90mr18428047d50.47.1767103966095; Tue, 30 Dec 2025
 06:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229024556.25946-1-laoar.shao@gmail.com> <971b1fd7-5702-4cf7-ba84-aedde0296449@suse.com>
In-Reply-To: <971b1fd7-5702-4cf7-ba84-aedde0296449@suse.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 30 Dec 2025 22:12:09 +0800
X-Gm-Features: AQt7F2qHtwGiy125cBPBzxihO5k0woWzVUT8wm7gFLPARBxX1UgvgSDw8HM-Q4Q
Message-ID: <CALOAHbBF_Q02amBXKh_iGPepp_-CbF91a-HAXa3pSnO4qBnX4Q@mail.gmail.com>
Subject: Re: [PATCH] module: show module version directly in print_modules()
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com, 
	atomlin@atomlin.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 8:41=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 12/29/25 3:45 AM, Yafang Shao wrote:
> > We maintain a vmcore analysis script on each server that automatically
> > parses /var/crash/XXXX/vmcore-dmesg.txt to categorize vmcores. This hel=
ps
> > us save considerable effort by avoiding analysis of known bugs.
> >
> > For vmcores triggered by a driver bug, the system calls print_modules()=
 to
> > list the loaded modules. However, print_modules() does not output modul=
e
> > version information. Across a large fleet of servers, there are often m=
any
> > different module versions running simultaneously, and we need to know w=
hich
> > driver version caused a given vmcore.
> >
> > Currently, the only reliable way to obtain the module version associate=
d
> > with a vmcore is to analyze the /var/crash/XXXX/vmcore file itself=E2=
=80=94an
> > operation that is resource-intensive. Therefore, we propose printing th=
e
> > driver version directly in the log, which is far more efficient.
> >
> > - Before this patch
> >
> >   Modules linked in: xfs nvidia-535.274.02(PO) nvme_core-1.0 mlx_compat=
(O)
> >   Unloaded tainted modules: nvidia_peermem(PO):1
> >
> > - After this patch
> >
> >   Modules linked in: xfs nvidia(PO) nvme_core mlx_compat(O)
> >   Unloaded tainted modules: nvidia_peermem(PO):1
> I feel that module versions are not particularly useful for in-tree
> modules nowadays. They rarely change and therefore provide little
> information about what code is actually running.
>
> This is supported by their limited use in the kernel. In v6.19-rc3,
> I see the following:
>
> $ git grep '^MODULE_LICENSE(.*);$' | wc -l
> 12481
> $ git grep '^MODULE_VERSION(.*);$' | wc -l
> 605
>
> Moreover, in the event of a crash, the log should contain the kernel
> version and usually also the vmlinux build ID, which should provide
> enough information to identify in-tree modules.
>
> However, based on the example in your patch description, it seems to me
> that your main interest is likely in identifying external modules. If
> that is correct, I see why it might be helpful to quickly identify their
> versions.

That's correct.
The motivation behind this change is that the external NVIDIA driver
[0] frequently causes kernel panics across our server fleet.
While we continuously upgrade to newer NVIDIA driver versions,
upgrading the entire fleet is time=E2=80=91consuming.
Therefore, we need to identify which driver version is responsible for
each panic.

[0] https://github.com/NVIDIA/open-gpu-kernel-modules/tags

> This assumes that developers of external modules actually
> update MODULE_VERSION() in their releases, but I don't know if this is
> generally true.

The external modules we currently use include the NVIDIA GPU driver,
the mlx5 network driver, and related drivers such as gdrcopy.
All of them carry module versions, such as:

  gdrdrv-2.5(PO)
  nvidia-535.274.02(PO)
  nvidia_uvm-535.274.02(PO)
  nvidia_drm-535.274.02(PO)
  mlx5_core-5.8-2.0.3(O)
  nvidia_modeset-535.274.02(PO)

>
> As mentioned, most in-tree modules do not specify an explicit version,
> so in terms of bloating the information about loaded modules, the patch
> should have minimal impact in practice. Alternatively, the version
> information could be printed only for external modules.

Good suggestion.
I believe it=E2=80=99s sufficient to print only for external modules.

Does the following change look good to you?

--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3901,7 +3901,10 @@ void print_modules(void)
        list_for_each_entry_rcu(mod, &modules, list) {
                if (mod->state =3D=3D MODULE_STATE_UNFORMED)
                        continue;
-               pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
+               pr_cont(" %s", mod->name);
+               if (mod->version && test_bit(TAINT_OOT_MUDLE, &mod->taints)=
)
+                       pr_cont("-%s", mod->version);
+               pr_cont("%s", module_flags(mod, buf, true));
        }

        print_unloaded_tainted_modules();


--=20
Regards
Yafang
