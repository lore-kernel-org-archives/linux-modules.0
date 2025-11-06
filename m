Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9433F8B7
	for <linux-modules@vger.kernel.org>; Thu,  6 Nov 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445264; cv=none; b=kkiyf4l8hnerddrjBF6Evt+8LGxi6vaa3i9C0fXKSW9+fMmbP34u4hD0n69vkPu4hUA5dSMmb4Pl8v4EtIJgfk1GgaLdUQIYk+Q4h9rYSa8bc/Ixw26tpgK9YLr9KUD0uTQ0FywBK9GgeUysPyYmdnAkYNgd0zl193gI554o49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445264; c=relaxed/simple;
	bh=Nzzlrmg2j3/3q8FevLWWH7MRQgKjJ5IbIXmjitSDalA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtQZSWh5awkGHVD8EcXil2fd0K19YZ0WgmAQYfvrvozl6jnbdqeKu4q6Httd87Guc3/n0zeQ39S++GkRcAfwauAkn6owEdVxZepwbkcWOsUsLRCnmvWIr3hb+6dGzYQ2eKI3ixR6VHUJpTH9yOv6uTHSLU7W3k5YodCOhFboLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDI5yXsj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDI5yXsj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2959197b68eso198505ad.1
        for <linux-modules@vger.kernel.org>; Thu, 06 Nov 2025 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762445262; x=1763050062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzzlrmg2j3/3q8FevLWWH7MRQgKjJ5IbIXmjitSDalA=;
        b=XDI5yXsjuHRIBicHR9HeQMGoU/S5kjM7KMV74m609W0w/A8LAun0LIPRUtdhNIiCrr
         fm5LHoj9uAHVrTSX5llcxtnsgq0EZY5oSfSEsgtWL9Pm/oILAgfhzvJNl+M3HU/V+UW5
         8MBmTO955fThVjjoZikeDV6IPq5DLVOxyuV5v6tQIIIJpXK4uzHTTmSpr1ifi7dZx61/
         l8k2Q9HrczAYndaSV30cG3ZbAsPwkwg933qL2Qpnls35nFKcbAZjc/adVqy2BeRZKX/u
         ijdbsZoGhCJL4le3ATeOS7EZ/O/K0BFOBs0Bq1jr82acTWCx/uuIE1/5PAp5gG/z8Ajz
         9Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445262; x=1763050062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nzzlrmg2j3/3q8FevLWWH7MRQgKjJ5IbIXmjitSDalA=;
        b=sx7G35lNa4PWwWGh7AQiJjpyBp/zEembW2b8c8AsDg9/0KKLs+6xbkHpxaPS8tXQ8d
         TpGBsSGrShhHCegLHbuYJbyb075qaBqhL3Rpiyseai45fio4vi2kFUtgzeyFir+AIwVw
         CjNdCrz8wPVfFCe/IrDLbD4iphz8sFc/hWvfGL7kjSlkeWEdKYxC2qZDkaTUN3m1Tqmq
         OByrwEGr+HZV8NvdD+P8DBP+rZVX9IagF/iSjbXhBRwXoMHyHU8gaJRiBkLk18pO6RAU
         fVKwGFq8fadJjaI3ARGElYtlUx8OCN2yrZ1fwATJfANe7wfU58oTa2hVpNdUcY3g2AjA
         grvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUExCj157xE7RshooubuFwK66L+rwb5L+EFzkn4HZYYSI8agww5Ssd+8iBVjCsIprzMUDtwzjkod/WSBrEQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg3Rsls3EPCeY1dr5I2GEhaeWzPoQVSn/xS786jMLbX6rEsUfd
	legt+ztj1XQ2sLCBZ3Ogudj19cFi+/I3CY4FrPFNsYIldZFYwTJFeGDqaiQnSkBahn0f75M873T
	kwWzxIDPhNX5Kk+U02pDUFzs1I5uNZ6zszsBg83HL8n1G0qaGHcmqsDo3VfM=
X-Gm-Gg: ASbGncvlHwxT76I0z4zah4g8/3l6SiUkwvoCwXxjiD9AYXuE9yz4oXOkxE1xhPN46rB
	nRzgJrSau3wr/5KTVzzybxJIsrkFWIjy3uCU3nHAtUNMZYL10k6hPMb1FYsN9mN1ZroJSj/961+
	BhBGAMrUwSmDW69AvDMFy0km6xOl8J5QdVr+jRNuSBunq+4XX71LD5EjK6Sscm1CCtTjIOm+ik6
	F2wcin4ljSNchA+gPgF3QpfPSnhQRynkRUn3wRh5sFBFQ8XZWvUIFQRUsKvBGOebz9q
X-Google-Smtp-Source: AGHT+IGJrSQnF3wP8OZ9swEpkYM6kSGamHzGXGAVorA64fWZ3wYfYUNWQRnDULUAfLehZdmVqoWOJHEZGY0/oHgrTL8=
X-Received: by 2002:a17:902:e885:b0:290:d4dd:b042 with SMTP id
 d9443c01a7336-29655c7b81fmr6092435ad.16.1762445262132; Thu, 06 Nov 2025
 08:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com> <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
In-Reply-To: <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 6 Nov 2025 08:07:05 -0800
X-Gm-Features: AWmQ_bnwLdgdkHf9H1YieFCO4w6r6305meY5Ank0AAAGt5lDH9YzCvkKH09X7BQ
Message-ID: <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:57=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Nov 6, 2025 at 2:08=E2=80=AFPM Haiyue Wang <haiyuewa@163.com> wro=
te:
> >
> > Strange thing is that ONLY 'rust/bindings.o'failed. And if I add
> > '$(obj)/bindings.o: private skip_gendwarfksyms =3D 1', rust build
> > will be successful.
>
> Thanks for the report!
>
> Would you mind copy-pasting/attaching the your kernel config file
> instead? i.e. the `.config` file (the `rustc` flags aren't the best to
> reproduce the issue).
>
> Cc'ing Sami as well.

I can reproduce the issue. With rustc 1.90, rust/bindings.o has
debugging information, but with 1.91, it no longer does:

$ dwarfdump rust/bindings.o
No DWARF information present in rust/bindings.o

Sami
