Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DE26E165
	for <linux-modules@vger.kernel.org>; Thu, 11 Dec 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475469; cv=none; b=FwIY+B28fjfGUpzN1RPZUGQYoU6OMQgPfpuC32VBnu2R27u9UcuidJ7ZF0RBR2zIb+iid6+LjQcO9fURVIjxXUMU3pZOwieph89VLbzFVqhPpc1gs5kft/RNpjcDBi68mqI29SVeEEeAjWz6u1k25/FLbeBGnUvoPDM6eiTcEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475469; c=relaxed/simple;
	bh=ivNcrvU798edTMwi7y8fOtYzeD2V9e+/wEf98MvOYo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZKVSYvEyHv631lwDq0V8UuzvbTUWzbME7PKhxrOjPyXkxgLh5LNVrshXOdwIbzaV7LDVraqLsCkat9CqbUtqm16O7xJhLscKyRxXhz5FNVNug+Rjx6vEALce9oIrzkiejornkbU2RQpuJp3mcgKMvZ8lXRwklfc7LGYSb6SQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJ8CoMHO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJ8CoMHO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f02651fccso82785ad.0
        for <linux-modules@vger.kernel.org>; Thu, 11 Dec 2025 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765475467; x=1766080267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=orfO0yqfsBSTgikDixigDUOR+wk6kmst9SflMIf/k18=;
        b=OJ8CoMHOrfNOeEMLUFH93FkRQAqsi9MsWBGUiCmXsR1qiP3VOQPtRnAvRPksqhoN4H
         +DJ+tq8mhQnAtW8N1nLdfc4KVtYrOgAjLK0Hif1pp7YDZ21jihmgKg6W9X0HWWcK/OOa
         q0oAsjgKJBf8UTInmwepDCucuPiOSsApVbW+BH6qiBdVbvsgAzqhepeBXgQOVk4D7e7p
         BREULXxc/DfUdD4poffkBB8U3iGj5EQfSpZuTq3WWgxzSqPteqOiqzqjSV1NnwVSr/ZA
         izSY1ks++T4Rc4g935ARMIMznZLSlepRG5n+Wb4GQM4vTH+1WqcjuwO35zb0CqTCPQiO
         QuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765475467; x=1766080267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orfO0yqfsBSTgikDixigDUOR+wk6kmst9SflMIf/k18=;
        b=WGmetW9cCnVxg9SbjE3gv/AS1jA+Cw4jsoqgzOOx1OqIb2zMVxL3ngkLwQKM31oaG0
         hmj//Vz/s/STAiYi3jaTWFh1lo8KsTOSKuRuUFmyB3artkU7GxIDZc8cr2v2lgV35UfE
         yri0yET6M1jLjSWg41xdaAZel2VCkoqJYvuIHZGBH2q7va4oOHOfh/C0EsB0bh8Ta1Je
         OjB2fTJsdF9tKhLoJkmnLWEXE8IEKia+FgQm72mFa5AUgwURieqh+wB1+SWCTqBRbxiK
         sL4jQ2LxXsWUxEWfg9S0ShStVsGXjZHzYyB84bTNpIL44c9FQwMvFoqtOqb2AK7YBrOd
         3Kjw==
X-Forwarded-Encrypted: i=1; AJvYcCXzozo9plJDGBjJOsuKoccn8Y0wzJjA43wWVy/A/7gHJJKS21n9Nn47fmnRzV3UFqNvWMNCSvJGwyYrzAYz@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWoDw9s5GN5F0JtChzx77KxPU0w7iqP/YuOiFIhVUdBqAcpeg
	WaJYJkJdFIijyeBLSI50f+fGe1kxJKjgJhTLOiQUZetPgwDvQ7LuvELJUCc+mboiWS+cPyk4orG
	5FD5stg==
X-Gm-Gg: AY/fxX4SFxtASoj8OoJSEXjYX7mhdxJv1Em97sGIn4J3N3isxXMt7G52otiUwqTRGVo
	AAf/5Em3qJn1yhAsZbW7I8a1NbyVSMy3vx9pH9aN6EB6b8gohWT1fMvwIIdmJxghDuLpeqA5qmI
	aJRWIHAy+c9yo8Sxv7H39Xc7aA+V+WToH0EkofIMgnKXtCDrAcQY78ZFUzddW73kLIA31JAdhG6
	OBFgmcfgkXX7YggkQaLMLmf+/ZJdEJLkPaLQHizTb9XlroUZnlNtB8OsZ4yEPPhJsnBx9/b8sEH
	T/2VYS/WsO05ptUAf7YhR/yUjjujutBjr0YPErZuTBTCYxuwwNwtv17FtC6IRRwTk9g4ofRO4Lq
	CqeEDK1aJ31WWvYrjYANHAbpW1AOHqgaeyWIXgoSEpSJAO/UbG9zv6C2tEC5zbXxI86CIuIYDGS
	WiPUt/K+ZmSSDO5dhHY690so5NhTFa1AR9S2jUNtouUO7/Sqtk6L18iSE=
X-Google-Smtp-Source: AGHT+IH3Q9jxK6GzFgU3zLCHyWZEg8sDw6GTy+v/i7WUFSzwUwaIKgoxo9FiY5Tr5tmpUd9qh2x8lg==
X-Received: by 2002:a17:903:1cd:b0:290:be4a:40d2 with SMTP id d9443c01a7336-29eed44d301mr3472305ad.13.1765475466729;
        Thu, 11 Dec 2025 09:51:06 -0800 (PST)
Received: from google.com (99.181.125.34.bc.googleusercontent.com. [34.125.181.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4e9d9e3sm3079126b3a.45.2025.12.11.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:51:06 -0800 (PST)
Date: Thu, 11 Dec 2025 17:51:01 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"Luck, Tony" <tony.luck@intel.com>, Chris Li <sparse@chrisli.org>,
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <20251211175101.GA3405942@google.com>
References: <20251209001139.GA7982@quark>
 <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org>
 <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3>
 <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com>
 <aTn0WdVv-S_EpQmS@agluck-desk3>
 <aTqAxfiVCR2ch4I5@stanley.mountain>
 <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
 <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org>

On Fri, Dec 12, 2025 at 02:30:48AM +0900, Daniel Gomez wrote:
> 
> 
> On 12/12/2025 02.03, Sami Tolvanen wrote:
> > On Thu, Dec 11, 2025 at 12:28 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >>
> >> On Wed, Dec 10, 2025 at 02:29:45PM -0800, Luck, Tony wrote:
> >>>> diff --git a/expand.c b/expand.c
> >>>> index f14e7181..71221d35 100644
> >>>> --- a/expand.c
> >>>> +++ b/expand.c
> >>>> @@ -535,6 +535,8 @@ static int expand_compare(struct expression *expr)
> >>>>                     expr->taint = 0;
> >>>>                     return 0;
> >>>>             }
> >>>> +           if (left->flags & CEF_ICE && right->flags & CEF_ICE)
> >>>> +                   expr->flags |= CEF_SET_ICE;
> >>>>             if (simplify_cmp_binop(expr, left->ctype))
> >>>>                     return 0;
> >>>>             if (simplify_float_cmp(expr, left->ctype))
> >>
> >> I'm not an expert in the C standard, but this feels correct to me.
> > 
> > It only fixes comparisons though, the problem still exists for other
> > expressions. For example, while `_Static_assert(__builtin_strlen("")
> > == 0);` works with this change,
> > `_Static_assert(!__builtin_strlen(""));` still fails. Perhaps there's
> > a better way to fix this than changing each expression expansion
> > function to handle this flag?
> 
> Maybe the flag fix just needs to be applied to the evaluation? Other op
> structs do the same. But Dan's patch did not implement evaluate. E.g.:
> 
> static struct symbol_op constant_p_op = {
> 	.evaluate = evaluate_to_int_const_expr,
> 	.expand = expand_constant_p
> };

Nice catch! This seems to fix the issue for me:

diff --git a/builtin.c b/builtin.c
index 9149c43d..7573abf8 100644
--- a/builtin.c
+++ b/builtin.c
@@ -616,6 +616,7 @@ static int expand_strlen(struct expression *expr, int cost)
 }
 
 static struct symbol_op strlen_op = {
+	.evaluate = evaluate_to_int_const_expr,
 	.expand = expand_strlen,
 };


I wonder if there are any other __builtin_* functions that need this too?
Looks like __builtin_object_size doesn't have this either.

Sami
