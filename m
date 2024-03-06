Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5A13E7DC
	for <linux-modules@vger.kernel.org>; Wed,  6 Mar 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749583; cv=none; b=XINhSZVrGCOPVuUdXdQqbY6SxH9S/hYx/pthK7x4ByWwizhXR8hqRsIMKsMmfYyrEGUG0as8c6Qz01KAQqrHXJ0B2orZKPOkhDWA/99l8jeRa8QZx+vz77xFaD38us5CppPJLfdl//ULI3tfuUQHkeXZQMAhQ5fugkbJpxVl3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749583; c=relaxed/simple;
	bh=BDZEFvO4/kpPxTSsZCGhWHb73PFi5c4MgCZxND0FO+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s85j5nltdauEgBNlf2Y7Zaq+8EA2kXyoWOnihp9vFSaJMJaZJmz9ftQ2gJLqcLQO8/dDhmOsIDTSOpQ12iNWM5NfS4sxqNw7hmZxcUtdiDKog6Ka2HO4SGrPrjJq/kLZYCpS43a9GwsC2aNs/7jwe9FdxR1Wo80eef7Ikmo9eiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFxuTyBQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFxuTyBQ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609a773ec44so20597b3.3
        for <linux-modules@vger.kernel.org>; Wed, 06 Mar 2024 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709749580; x=1710354380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDE+SekCPQHTVQBs9L5kK3RRx6oyNpss4llduwnwBdI=;
        b=eFxuTyBQjwZ0AVmgrPylVlC/ejsjRjuWQkZmGpAFwj/CQ2XxCQi+ES/sTvOx6AkywE
         GK3+/JJe5WQPnscceluW81Xnd+j1GYLrtvI69GkuoeWwpbcMmJ1rtqngoCMVJXof8nLb
         NPG2Eqt/QoCEN9OCT4xrug1NmzaNCmQvpdgWLdXEpKD1n6Wq4OioaJo/+UM6GbcQU24z
         rYChXs5QiEM0hXqXKwiuGbVoMkM1V4uSXW2wNln/9CmNE1RCPW/+YXKU9uGGeapx559x
         uJThQ1Kjr9G9s/V/9xBxFeuSh2syUs8P2ywyWdNwvsVPcw9FfmgwKXva6bcz6DosWxLQ
         qRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749580; x=1710354380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDE+SekCPQHTVQBs9L5kK3RRx6oyNpss4llduwnwBdI=;
        b=BnhZMB7KceA6DaGc1LMFkSmxowP32PSFLIEnNwv6cPgwxG1okAP6tzRv/Vbs8EShwO
         l+CKxSgDpNDp1diAhTQnltQt5BZtroTdNuDzlcE5Dk5lAq8yu605ysFETHHQHg8Xl3OI
         TdT/Ssa/+EZvHLcBhmPjqcmVx6Urvw3hpmRVmrLgx/yTAIELJF6VDb+3nXz7pEDH6p3/
         SjPOlSaB1Xv66dhMubDC6v4EEeV6lFIFmbMg+yrFbXrik4o+utCANg3pRewA5QNdXY+d
         JthDacrzPL+yPlvn273AHF7B++sqHpB2tMXgFKRyyh6HN2PMI10NstL505As92q2K8bu
         3YqA==
X-Gm-Message-State: AOJu0Yy8BGvPIGssZ9JaI9NyCZLa5SMzjOg1X1OjWH6MUZKkYWUI9Fmb
	cZGXkn+211EgJ0AciP1yEJr9g4MrzbJK6xZ1zZ4+YbiIznJGiCBhcVaBye6avxv8KiFJsPQBnYs
	87VKrdV9W9V532YM4kxVDurH455O8y8il9zQ=
X-Google-Smtp-Source: AGHT+IHz/qquhe3pNcOD3nRcczeZlCQKUjRX0P+iTRLpxBc0fzEzpRdpe5eMVjb7acgLaoLLUHsE/S3F5xFg9R1qgQA=
X-Received: by 2002:a25:cdc3:0:b0:dc7:423c:b8aa with SMTP id
 d186-20020a25cdc3000000b00dc7423cb8aamr12029446ybf.12.1709749580537; Wed, 06
 Mar 2024 10:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306145804.135709-1-lucas.de.marchi@gmail.com>
In-Reply-To: <20240306145804.135709-1-lucas.de.marchi@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 6 Mar 2024 18:26:09 +0000
Message-ID: <CACvgo50zhPA+RZff2=JNYZ9Qf42MZvoyFJm6fuJt=OuxaCWLVA@mail.gmail.com>
Subject: Re: [PATCH] build: Allow to install over dirty dir
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 14:58, Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:
>
> Before commit e98cef6f3f8c ("make: install/uninstall tools symlinks to
> kmod") it was possible to call `make install DESTDIR=<dir>` multiple
> times. Use `ln -sf` so the symlink is always re-created.
>
> It would be preferred to remove install in an empty dir, but there's
> not a bad consequence of re-using the same, so let the user decide.
> Fixes the following errors while installing for the second time:
>
>         ln: failed to create symbolic link '/tmp/inst/usr/bin/insmod': File exists
>         ln: failed to create symbolic link '/tmp/inst/usr/bin/lsmod': File exists
>         ln: failed to create symbolic link '/tmp/inst/usr/bin/rmmod': File exists
>         ln: failed to create symbolic link '/tmp/inst/usr/bin/depmod': File exists
>         ln: failed to create symbolic link '/tmp/inst/usr/bin/modprobe': File exists
>         ln: failed to create symbolic link '/tmp/inst/usr/bin/modinfo': File exists
>         make[3]: *** [Makefile:2679: install-exec-hook] Error 1
>         make[2]: *** [Makefile:2553: install-exec-am] Error 2
>         make[1]: *** [Makefile:2439: install-am] Error 2
>         make: *** [Makefile:1848: install-recursive] Error 1
>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Closes: https://github.com/kmod-project/kmod/issues/35
> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>

This matches the default `man 1 install` behaviour, which overrides
existing file(s).

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
