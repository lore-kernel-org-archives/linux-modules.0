Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB71C68A3
	for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984911; cv=none; b=JkSzb8/FiUTZbNwp4aiTUsqFJQVjaHqMWNF2RV4HB6ig7CSMKY0wAP2hf7oUA8pDMc3yAO9kXuc/1AtsDyrUXHOapDUoYS8hYMthSG+GQLFPCqLXQmZaLEJSbxMhItjzv0r9JkSj5Ibh6oBx6yeYqXrCqaYUscvOXrhTP29i5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984911; c=relaxed/simple;
	bh=Hq7wHhOqLYGmLAB69SsBZQs1aQChOJXsjkE5jCy9KSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EECF1hudOg+optSc2C9/91HHCKgmTZg/Vp7JrBS2OggeQwYjDig8sW0GFX0RpoxzVzY0WvVIXCsKugfEukOP9eMzGcqjzEJuiCXwPDKygRI32Y+9oY7TEIEoMtf92XO+cweleMdq18+npax7CS86SNDCNgmUkqJkSweOT+lp5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dYblkblG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dYblkblG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaecf50578eso268179666b.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734984907; x=1735589707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BTFlSrjGOG7BrJvzasBCEZjGgnBLHjQ2uev3GT7oZnA=;
        b=dYblkblGlpVIAt4q1rOxu8J00xYTo4hV/culL8JwzH3FuNhqK1FjgBwJqK8A7Inhup
         qfUW812d0JGXelwoVRgXxKHkAzW3yjHMiAkB2rlY+CqZHjnq2sMwpI9zApb8FbRGWc7M
         z1M93dcIWHULxtzobcc03MV1XNRGFK3xcZiHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734984907; x=1735589707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTFlSrjGOG7BrJvzasBCEZjGgnBLHjQ2uev3GT7oZnA=;
        b=pPE1vFQaGWZeRz55vpXXmT6uoqaly56wZugbx23jTF8dbjNuPtC7NGkOzHyNfoKUeP
         x/Gi7I5VSQm4FPKhuJo69sFh8EM9dwpBxbwCYzRx4NZfCMlltnBik5veq7KH/c+dHf8P
         NuHWbImUf2dNpZ/ZC16Rr+GqfTq//DICp5wuXo4YYa0Fep89Z+Wfhcd4CvgQUMpsJOAV
         Agn2riXAlQXMZZLmhOEGjESz0UGZ/mug29/sF1uahNByPgZZQ5yE/5DI+o4o3/327WMh
         I3LMxlDqAP+0nFboIOt7mu9AZiaCfyfWSfNPt+mp//HUfm8YDrOeIu2h38PjWsHca0lo
         3Kzw==
X-Forwarded-Encrypted: i=1; AJvYcCVJao1S9nJbQsTsfWdj/TxpZIq2bS8Ewm84HytrcQqBcS+Zk+FrkwG19aS+0wVb9KZRawMELg+oCi05Q2wE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9KEOsaNKooSlzGdBFJSniXgKv8FC+SWVbraCGwcR3yAkUQNO4
	Gaq+jk8+WAIxeJzBbgb6ix7Kxpe32caHhP6Uxx7jnv6yLNP5USvzINxvjfIjfJkhaorpFR+4dZ1
	Bu70=
X-Gm-Gg: ASbGncst0IS0KK3b/svJIhb7TyPC9irj/k5zf/HYNqnvZTkXZSH9WbLQR31KmXTBzDK
	dZr7aMe9OE3hsFZ9S5OVDKpq5lWBkj4eBLTDM8xug5qsutz1hv90e7jkqcEySFdiJB6DvvvgA7u
	Be6u/aopxDBikE8NEXkk2EVTj2tf4dtRUmVxCl59qbqDxyloRrwk3zvwLrxH/J1n2MHNmWMY2Z6
	ZCHYvAylH6/sKNqRlQD+E0ny6SMXfGTHenB/Yp9Z6x5N1TOMLHKTGrnGgQEV0ZQXgef68Z4dh2O
	7SyThorsnu756ztENTPmhonJ2PdATF8=
X-Google-Smtp-Source: AGHT+IHnBCSU6SNhftOB64WO2jsPexvbhVJIQ4e1KLtuqDFfooYgXkO03Pa/2JVjd0/xmf0ifpY/ig==
X-Received: by 2002:a17:907:7b9a:b0:aae:d75b:6e52 with SMTP id a640c23a62f3a-aaed75b7b2emr511338266b.4.1734984907491;
        Mon, 23 Dec 2024 12:15:07 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe48d6sm565069666b.127.2024.12.23.12.15.06
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 12:15:06 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso849779366b.1
        for <linux-modules@vger.kernel.org>; Mon, 23 Dec 2024 12:15:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7bNeAvpm3fRSHyNaB92foSm74KQDxhDp4jX4rlINvq4RZ1eUKE0YWZv1ykieCzg+ffl/rl+mMAE4hvCXP@vger.kernel.org
X-Received: by 2002:a17:907:9802:b0:aa6:834b:d136 with SMTP id
 a640c23a62f3a-aac2d435474mr1474265466b.33.1734984904971; Mon, 23 Dec 2024
 12:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
In-Reply-To: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Dec 2024 12:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiihsw2QnwsgYr7xOTpqfjo5ojOaNTBy8hj06Gz+-BDQg@mail.gmail.com>
Message-ID: <CAHk-=wiihsw2QnwsgYr7xOTpqfjo5ojOaNTBy8hj06Gz+-BDQg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules fixes for v6.14-rc5
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Dec 2024 at 02:55, Petr Pavlu <petr.pavlu@suse.com> wrote:
>
> Luis asked me to look after the modules maintenance for a while, with the
> plan to rotate it with other recently added modules maintainers/reviewers.
> This is my first pull request to you.

I *really* want maintainers to give me a heads up before people change
and I pull from new people.

Please? Otherwise it just takes me by surprise and looks unplanned.

               Linus
