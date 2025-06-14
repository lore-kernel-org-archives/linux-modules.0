Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933E175A5
	for <linux-modules@vger.kernel.org>; Sat, 14 Jun 2025 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749862467; cv=none; b=nLCN12AbWa98wdZCSd67dPFD1hKFA/G5yxNa9MZTF14S674nZztmxjA5WPEqZxnPYlmH3QYgOBSw+IkY1GthsxjZmGDgfJw8BwNB0NiHvmtEk49appQgxYiZVUU5YNcONY+UvWzEg1RjNrHE5JH7MG79yMpLOL0FvcwXrkWt7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749862467; c=relaxed/simple;
	bh=dbg3c1BYh2RqngzJb5eNWzqDUU5+7bNmKWGAXK29fkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejp33bup16FDIhAV6A+nt96ICTQnXjpDeolktiKsuPkAkhFeM565wKHdLP/n7RCkHq6IxMAOtoFsrAeyNy6AGVpb23mLmJUq4hm+DMKBTcvRHjWjl8+ETegRR9Zo1fJMQk+s4Nw7HF1rZxS5dFs9N+xXKbO/28dsqm+tlm4xOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WezgbJk0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WezgbJk0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2348ac8e0b4so40905ad.1
        for <linux-modules@vger.kernel.org>; Fri, 13 Jun 2025 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749862465; x=1750467265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbg3c1BYh2RqngzJb5eNWzqDUU5+7bNmKWGAXK29fkM=;
        b=WezgbJk0dtNUYgx24URetCr6EXq91Ga38mytsbVMSvQi3xAQnTtIvKvc1AjVq1GNEL
         UodO33phXhFGQouhEwYlWk2BhgrbOBJMRgN9mxMdKZ97o49a0IQIJpAv4MDo5Hk46PgH
         eAkkILbbUz1J1ezLysvMlv5ElzF6WaRVn4Ub9EiGorspTF/vytjkNvFG/RFPH4a/dRbR
         OTs+O4QmXqsqTPt05pM5jedM8u/uvv1p79t9RGpaxjhHEbyUgIcA7i9Dx+dt28KzMK4f
         MD9FQo+ZG+tOoahB+S1zTfA+8g/5vGIJ7v678WlCNtMvYytRYSO5WRzvrbX1mEyNiEsE
         P+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749862465; x=1750467265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbg3c1BYh2RqngzJb5eNWzqDUU5+7bNmKWGAXK29fkM=;
        b=QjX119z86aKK7NKmENl9I4pbvsa9dQBTvYS4krsWG+PqB8HBkr0qNHInfhZeKJR4tf
         177irAbXmGt2sxVw6Q8cN2EeVDRiXkOE5NF+wwcwaRfAwVMnOghs5ERHchIi2uUn/M1w
         cULb2NFdZ5EU8jMoBeppbG0ZpeGrBTNjR+RSfM+BDye87zTDhAjLQJPXvYTcWeLo0zPm
         hjHl1WjF+Y7FcZFBKHlUmvNV3xJDzvGTQFtq7s9QCxpBeAKBY3sb/HURqlr7n0P/1PW7
         qTeprId/DJxuU2tds9pSlzZpA7riQ4T/MK81odhga5Cyz6HBrLShUYV80dutlWa8y7wL
         vQYg==
X-Forwarded-Encrypted: i=1; AJvYcCWCleZ0eUFMqg6QOZDfO7ROVdlbeBCQqLpPSUwRqrZ9GfjNGc2FPscgIZB5QovHXmoX/926+AzdeRrNqrtX@vger.kernel.org
X-Gm-Message-State: AOJu0YykANpwbIehg4qtrFJxoQhstcMDx6sw2phWaTFJmfkPoWqQmJCi
	sgXjh4lrbmMrrMmb3r4bVwsilZmlDInnfiFfQt1StDktvNaBSsTUCyqqakXNYZeQ5IlQcnB329Y
	Y6R/rPGmguvAI6tbOv+Nvf4eXrPRpApLB2aeG5mxQ
X-Gm-Gg: ASbGncvfDRvws41mEoiZfUeCFOVR+ovW/lcBePdGZJyOOwkqj2miYctZ8b7ta7OK6Jz
	YpL2bbYpP8A8DatFGIsFronhVkLB93pJQhhrYTaTvmMmyUaF1/PmhsEIwoGsHJp7xmC7Z0whOpD
	y2R5WEWVty9rzAEEj1u8pq/oqTvslKfltFdQzSu5lCYnvXE2iOyQM=
X-Google-Smtp-Source: AGHT+IF5JrVHVbiN/102jVBcJgf8pP7Edb6rcI75OIdKcC6Rl/eoRwukBdcUmUcOznU3bQiIsNg7MVhxwBLn+Nvp0Wc=
X-Received: by 2002:a17:903:1107:b0:234:afcf:d9de with SMTP id
 d9443c01a7336-2366f01c6f8mr325645ad.29.1749862464820; Fri, 13 Jun 2025
 17:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154926.1237033-2-samitolvanen@google.com> <dec42b04-b76f-4a2e-b060-9ac999fe1462@suse.com>
In-Reply-To: <dec42b04-b76f-4a2e-b060-9ac999fe1462@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 13 Jun 2025 17:53:47 -0700
X-Gm-Features: AX0GCFvhflmbUjvvF_yAMLbU4RfChKb2aHfDzBXIK7IMhzB8uMQ9kdWUKlDyi7o
Message-ID: <CABCJKuctMAeD0HjnH5D8ji-g1ZKoev-u6ni-UiDL3qtQhpfbZA@mail.gmail.com>
Subject: Re: [PATCH] gendwarfksyms: Fix structure type overrides
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Fri, Jun 13, 2025 at 12:52=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> Nit: This code was the only user of __cache_was_expanded() and
> __cache_mark_expanded(). It is now possible to merge
> __cache_was_expanded() into cache_was_expanded() and
> __cache_mark_expanded() into cache_mark_expanded().

Nice catch. I'll send v2 with these dropped.

> Looks ok to me otherwise, feel free to add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks!

Sami
