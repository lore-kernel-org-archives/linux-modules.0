Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D33128BD
	for <linux-modules@vger.kernel.org>; Fri,  5 Dec 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939535; cv=none; b=FJgiiTg0N2sAEhCdBk3u8MxIYq17LKThNcDbZBF6HaMWiTM1wXvk7xBMT1TUfz3HPpH0zZA/YmuZz9EiStXv86B7XSXlHzTOGLDYawGKQqoRn3h9lyEijq0ro78sdbMZVuDojVNSYfYYQSbZZ8rlGmNpMeI8THnXsSdi9xZirr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939535; c=relaxed/simple;
	bh=OSxQSgaO74Ist6Qy2I2ydiBk+D6zbq2c9HBhxCAzHag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=U1X6LjSHJ7QUmtyOe9pHbdYZnxvWoCGjd9acP4muz5UhG9bURokNPuG9fr4C4ne0qxfMLTuoTy3H81PEBlQMKLo2FaLEFuPOpWRTpomQTdg6JruHB57IQIbpBSZzDMCL/aJf8CVt893sG9ZnIrCXpsUhHt5rq//qjU28I131d6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoOXZ1fu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoOXZ1fu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so19296855e9.3
        for <linux-modules@vger.kernel.org>; Fri, 05 Dec 2025 04:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764939529; x=1765544329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vvDpFJFk+V6cvoTCKOK8q907ac/jTowZtFGXPpMCI6k=;
        b=AoOXZ1fuUEV0Z8Kn3kJ2upGgoEOBNCuykATYYJ7zIqAyA5R9LKCvn0eQPMxCj5qM+g
         6dLy/1Our9oMgg/FNgAD5Ewl1RjjzUaZNxnRqERM2C2SBH4mcBNjigkkVHq2b0l57J5t
         jcrlTJhW8+RGdIAFRM/AyndnI8fISiz7+FQbIFfXd81zk1qC77raEzE1mkxVonBSpyPb
         MbD+hQy+4KVAk+3WRVvcZyeKCVqcn4SlN2FdmtM8csbROH/EGozPXHT5f3JNKg49idLN
         J2hihH4viwXfr0y6dJ5KnOC5wpF1lTkVcG5m4FxUO/xXpgrnlF07ISPp6kzqOnAOkzgA
         tITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764939529; x=1765544329;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvDpFJFk+V6cvoTCKOK8q907ac/jTowZtFGXPpMCI6k=;
        b=vlU+5XOV12gdu5sWPAZ3wEzJ4DB22f8qRr7xb3aHjbppIP21o1HEkEAuNpuEqyoi+8
         J59q09siCZtLUeomA75Qx462Sj4P58wfgIS0QKUo6kJdf6efh1VwVMO/8WBDvdpeh5te
         4tOCRUZsflMQ9ZKVhg9/HtB47g8SWxFOBCk7RJPGLt2I/KMguRBsXSvt529Ygj6GfXQg
         5TNSr0+cXjhtZZihdfmeMaG81LyxHXVnDpXMQThhPeaq/F3En3Zybwzezlwdty1kuyK2
         E8MeNp3EUXAycuHiW9cxuGmI8VLfEv/HjlDu+Ylsm4UfO2RVH/fJXaYVuxQBF4zTUv0L
         ZHKA==
X-Forwarded-Encrypted: i=1; AJvYcCV1wFySDE2QSP1JifSu2pvtWO/LEPgjko1OIwb9kJl2+SNkUpnlprZJ1afGIwf1aHKh8m12ZeFU3tPqwMOM@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDN8Uh3SCTDz6FafhhQVROqu570Ewfa16yXHvyi+es+y78e2j
	d4Quffp741JZOZ5NSY2/fkq+qY8GzsRlRPLQMyEy/qC3BEZogDlGo+K4j9aAykmfnTg=
X-Gm-Gg: ASbGncukknkZP7/P7DLeBHMA9KdIAMI2ruJz0LuGGN0dwJwNHIU5oZDRdlIWOA+nS7A
	ZS3qy8VmryBt7bdTBH6U0P06YdkqvR1pHeeEMP6A4lmS9cKRplpO72mzBtWzDUWIquLSMR7419e
	+kRnLrYuzTsBCbGp06qfz3UjXlt1tXR7jFJtbAhxPDSOwBh55QApUXOr9xTLFiR6/fU1GSkxunh
	3tjrhtTf+tNtRiMsAmxSpBlfeSQZcz/RYh+fNikXdivhSRQrXHUrlOdI3UOKKShE9SEuM382GOE
	zn9A49sr8EipX5peqANBoNKFi/38Dd5+8+1XY9lJ7hEmin62J/hq1VHf8IV1M22KDMDJR18/Ynj
	g88auuv3Q14BObpoBtNvYKtMTM9ph/U1DlIImwse2L94zwDJYFHz8EFahCTli0AXHKJc4bGxNZb
	szDaF+EZMl7wDjJ3l2vRip5KPkI/Ny1A==
X-Google-Smtp-Source: AGHT+IGleborKQCrbq8DmtASF59YZO0WpvBhiHKdLlUD/UBGnoL4NMp+YZWh4r36RAtoCvyopgKovg==
X-Received: by 2002:a05:600c:45d5:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-4792f39cc82mr78538125e9.31.1764939529325;
        Fri, 05 Dec 2025 04:58:49 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02e806sm59378815e9.3.2025.12.05.04.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 04:58:49 -0800 (PST)
Message-ID: <31cdf723-a776-498b-8664-4735cd76669a@suse.com>
Date: Fri, 5 Dec 2025 13:58:46 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to
 sysfs.h
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-4-yury.norov@gmail.com>
Content-Language: en-US
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 David Laight <david.laight@runbox.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251203162329.280182-4-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 5:23 PM, Yury Norov (NVIDIA) wrote:
> The macro is related to sysfs, but is defined in kernel.h. Move it to
> the proper header, and unload the generic kernel.h.
> 
> Now that the macro is removed from kernel.h, linux/moduleparam.h is
> decoupled, and kernel.h inclusion can be removed.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
