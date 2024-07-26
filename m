Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF417BDC
	for <linux-modules@vger.kernel.org>; Fri, 26 Jul 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011781; cv=none; b=Rmw8FO7vbHnpDF27642DlQsGn2g2F/JfJiqz/L3usc/Kvy8yfFohaSvg3q9NNuCGd2i/LE4ZgtXK5pE+ePuibaDCy8FJUEgJyQiwySshzI9x07t2doobHgsF/sfAydDb3RR0VQNTbj7VbSKuCaoQB2vh1zrdzLXVsQ0lFJf5AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011781; c=relaxed/simple;
	bh=tdYSfOWf/SV1uFaMUE1ec1v+BMVlp+xPpRRA+oEX8uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMX6kUNt/tmG4E7gQBUWWjOWcwgpVezF3WLAvm9Ws0n0G3LoUf6Bkpwslbk6Slktk2b5XyA3cCsr/s6Nxg4W0DdXJS7r/ZO9ykWmo8Z/1CM74CaXTYPSfG5oYrgvXpoJJ37WY4pBYfBXyad8YkeEosnhr91sWy2IXtMx6e9lQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuhrYqix; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuhrYqix"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2ed59200so16886011fa.3
        for <linux-modules@vger.kernel.org>; Fri, 26 Jul 2024 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722011778; x=1722616578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByzIZ1BITVtfZJUk4FnFaHkTt2nIO23plx/AgKa+I0I=;
        b=LuhrYqixlcXElmx1spMhRpZHjyZY4yNGGSRzR5kZw3x4DbawrXrdat9szzoxJ+lap0
         HMLzWQEZTvjucS5UdReY8IsE+L7PqR9nOAWlzUqdRCP7VzVCETgSNLWA2e0N6J7PK9pe
         nQ9Kr5lVmTCuBba225Du6e75GENHA6OcXZxWr5nK5AHkLHxf8MMMVwLeoUXq2ffruvyc
         M1VihJ+4U0a2v8r32MzJ5grRdYA3H9F0k71HgAM0E/KN7f2z6SKgCbS/EnwJfdDE2R9x
         QlPq4n7GjgipRx6fiUMoqM/evNu2KM0muaaAu28+md/zQ+Gn6UVTLB0mv9nG18mwBRlr
         SmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011778; x=1722616578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByzIZ1BITVtfZJUk4FnFaHkTt2nIO23plx/AgKa+I0I=;
        b=ZkoagLC8QBsPr7hbnvR6+5k7bLS7JEDpb74s8zB0wTWMDsZw+bd6zhjXOAO+CwuuwZ
         Fj+n2NONiehrno+ymfwfwmtBfuRHaaDs1i/NiAzAbl/k+gh4yKkqF/Lu68LpMHhMTqKs
         VM0A+8TX+vgsw15LAkPB6DIUijRIEzk7dVo8J0PgQ1WTJ9X4izFw4QQMv5UxHnkNvr12
         JoRGSK/NAI+jn/D946x00dqQnhiMFaqV40yyyBl7lIlhH909dmvxEIkSofo4rmAlpAKU
         FPI3Lz8mfCfrsjKsvvtROMA4eaOjU5U5EB51SbABu6yauNh74utiRvNCyCPQrIHnuGvZ
         L/dw==
X-Gm-Message-State: AOJu0Yy2vBG4NqIMUa2XvAY5+y+lCrWKV3EJehOW91ci7psjTvXKrYYV
	KXZzfJPPTU28JgS23OEbFtIKdeLr0uvGq72mkM15OTMnbDHwlHqFKeq/llfaqdN5pOxICbmsv0a
	UWTzNOCJxuKkRiwVukoTeSFtvlg/WFERo
X-Google-Smtp-Source: AGHT+IF0Pe7amm0sNjhemU6DlOniE1po11xAqikI6Zw9skjbbsjg0Gc3ahXYuNz1+2hwuiljFVfCR2+FZgua0VzelXQ=
X-Received: by 2002:a2e:9dd4:0:b0:2ef:2bac:bb50 with SMTP id
 38308e7fff4ca-2f12ee14eedmr1701141fa.11.1722011777708; Fri, 26 Jul 2024
 09:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723185921.1005569-1-lucas.de.marchi@gmail.com> <20240723185921.1005569-2-lucas.de.marchi@gmail.com>
In-Reply-To: <20240723185921.1005569-2-lucas.de.marchi@gmail.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 26 Jul 2024 17:36:06 +0100
Message-ID: <CACvgo53D4O+-bEDV8OQQjURAUNQ3i4NjOGqefNk2po68DbguZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Use SPDX header for license
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Lucas,

Thanks for going through and splitting this, even though wasn't
particularly fun.

One small note inline:

On Tue, 23 Jul 2024 at 19:59, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:>

<snip>

> diff --git a/m4/attributes.m4 b/m4/attributes.m4
> index bfdb50f..208dfdc 100644
> --- a/m4/attributes.m4
> +++ b/m4/attributes.m4
> @@ -1,23 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl
>  dnl Macros to check the presence of generic (non-typed) symbols.
>  dnl Copyright (c) 2006-2008 Diego Petten=C3=B2 <flameeyes@gmail.com>
>  dnl Copyright (c) 2006-2008 xine project
>  dnl Copyright (c) 2012 Lucas De Marchi <lucas.de.marchi@gmail.com>
>  dnl
> -dnl This program is free software; you can redistribute it and/or modify
> -dnl it under the terms of the GNU General Public License as published by
> -dnl the Free Software Foundation; either version 2, or (at your option)
> -dnl any later version.
> -dnl
> -dnl This program is distributed in the hope that it will be useful,
> -dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
> -dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -dnl GNU General Public License for more details.
> -dnl
> -dnl You should have received a copy of the GNU General Public License
> -dnl along with this program; if not, write to the Free Software
> -dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> -dnl 02110-1301, USA.
> -dnl
>  dnl As a special exception, the copyright owners of the
>  dnl macro gives unlimited permission to copy, distribute and modify the
>  dnl configure scripts that are the output of Autoconf when processing th=
e
> diff --git a/m4/features.m4 b/m4/features.m4
> index 82a244f..6a9b5bd 100644
> --- a/m4/features.m4
> +++ b/m4/features.m4
> @@ -1,17 +1,6 @@
> -#  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
> -#
> -#  This program is free software: you can redistribute it and/or modify =
it
> -#  under the terms of the GNU General Public License as published by the
> -#  Free Software Foundation, either version 2 of the License, or (at you=
r
> -#  option) any later version.
> -#
> -#  This program is distributed in the hope that it will be useful, but
> -#  WITHOUT ANY WARRANTY; without even the implied warranty of
> -#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Gene=
ral
> -#  Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -#  You should have received a copy of the GNU General Public License alo=
ng
> -#  with this program. If not, see <http://www.gnu.org/licenses/>.
> +#  Copyright (c) 2015 Lucas De Marchi <lucas.de.marchi@gmail.com>
>  #
>  #  As a special exception, the respective Autoconf Macro's copyright own=
er
>  #  gives unlimited permission to copy, distribute and modify the configu=
re
> @@ -25,7 +14,7 @@
>  #  Macro released by the Autoconf Archive. When you make and distribute =
a
>  #  modified version of the Autoconf Macro, you may extend this special
>  #  exception to the GPL to apply to your modified version as well.
> -#
> +
>  # CC_FEATURE_APPEND([FLAGS], [ENV-TO-CHECK], [FLAG-NAME])
>  AC_DEFUN([CC_FEATURE_APPEND], [
>    AS_VAR_PUSHDEF([FLAGS], [$1])dnl

If I'm reading things correctly [1] [2], these two should be:

# SPDX-License-Identifier: GPL-2.0-or-later WITH Autoconf-exception-macro

... and the exception can be removed.

With that addressed - either as separate patch or squashed - the series is:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
Emil

[1] https://spdx.org/licenses/exceptions-index.html
[2] https://spdx.org/licenses/Autoconf-exception-macro.html
