Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BB3A6417
	for <linux-modules@vger.kernel.org>; Fri,  6 Mar 2026 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821668; cv=none; b=a5ETNIG9zGuJt+kikZUxuCfNe5Q6NhosYnRjON0ZrlcER0PGf8KyeI62yIvHkvXVfskuzNddzGYGI5obRPjlQZ03MC/IiP9UeEegMLm4UgEGEnS7IaKQHk0u23GGr0pO2GebVYap6ZtzlA39Aj2f1rUD056BOAvPRGw39cdDrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821668; c=relaxed/simple;
	bh=C0FpvF+Eai8YIFcFjlslWeL22N9NQEVFyXAeA99g07Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhomRTrAlKqDkHsvt5CZr/tdL2uJvXjG86uf5SatuqyTPrsIbnCwLevE/oPF3gs5h0Q/8MF0QhPFiEIhn38MlFYY30BqgO1Ai0H1P5UyyPGai09E00eNnokhOrgAtRK2VErJVYey4auu+9EvGhrI8rXLoOIGe6ff7txXckW0bXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hm451rp2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hm451rp2"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b93695f7cdcso1279635466b.3
        for <linux-modules@vger.kernel.org>; Fri, 06 Mar 2026 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772821665; x=1773426465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5lHZOXkujkn3ph72tYgDlAYNUE4LM5JcTk02pGHeUU=;
        b=Hm451rp2KoSPRlW/5i8AaWMT+ewKEBBkOsgut/bUfjwbknD+ma1WvCJzy/Kaur2vfV
         eVMrkKWEyoQEF2DtD4QChx+vXb/WYGhMClfGz4E29lNQomSDQdfUJuXNbUbNjDOdqa9s
         GjhOhnyyj1pRP7zlrAYgDmzMI0VnhlAmWUCtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772821665; x=1773426465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5lHZOXkujkn3ph72tYgDlAYNUE4LM5JcTk02pGHeUU=;
        b=bbU+NDqLCsfXcWWwjm399il78PFEjNqzv3DnxXyiyC/1GrXdjKt62JNS3yyYf3uXuP
         B9HzM3XrBCgaTVl6U7JWco9drOFcOSWt9S5Mnat++EKiRf2ZfR/fDgJ0MCeC1ws64+F8
         KTbr7Ar/Z/SKAcz5yjlCkQqwwP/OsJuY499SSuc7pnLy9Mpoc7JFNwtTWXUlQNokaMaJ
         9dB+76aJw7rGckseMMj+XgVqKded32mc6vvxUidmkBABmW0dZdHw5tWoBlwkMoJ9E/xF
         rucSaG443nd+MLDsAmqifj2EJ0MvbNugkbHRl18sa5ZRqjzaVgLYUB6PqeS+1o/83COk
         d9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tehRnYbxvi71CMyc1nWm0xhUJHXh0yZ0FSpiOVw9kZ8Pf6wmM4LuNS6+s4Z2RHS+FqpAaox1h7YCsQ6w@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1g96wiglZUAMuXwoUBy4Z2qY4sL8GRBjm3z4MFszDQcjUuR3
	yhv1FsfATLpI8CiSEFFeAdjKMhGeSzHeAzBLQHy2/qYf/nnHeka9/TSvdk3MFF8IShMk/iB4/23
	TC7UG88c=
X-Gm-Gg: ATEYQzwAYJ4+xGp49sVRB0pP2JszUG8bVSjgUUeKNv0Jj8tsU8bDZZYDFxB8vAkBv5j
	2FRuGTHX4WRux69WT+mLfki5vZTSgZMK5/61n2iHg2v5R/HTDPzf9oNjn08FExjpI1530f++ij0
	DxHZV3HKCG442hiIgI2w3GKHC4yrqebSjNBLair9WFxX+G2PS9iIhRZF/bDTb/w84t3gsrI1YYK
	RT4M3PUoQZ4HEmkifZ8dT1ql/QTbH2PBiauchM8RWn7jl1BAk5IEaT5BgOi+fkO6ibT8vxkn8ZH
	W/tTXRhZ2/Sk9zj7H9AjfUMpTnHmj4YJWAMhxs5JenjAMTWeDxUwJqB64Taksk6BzlrLa6hrdnI
	+P7WusNfBUvvqR9BWNqFYBGlfMYxaBFCtZHrj+xMBInZCHP8J0GTlZN21Cc2rsY005//AiJwOWm
	JCOnMBxStlY0GdedzFA8JvfYBBrverW/+swtjwM+slUJblYIZWK0p/oZs1TLbz3TGXwkVjWabg
X-Received: by 2002:a17:907:7f86:b0:b8a:f7fb:4f4d with SMTP id a640c23a62f3a-b942dce9ab4mr174557366b.16.1772821665072;
        Fri, 06 Mar 2026 10:27:45 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15d532sm79414466b.54.2026.03.06.10.27.43
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 10:27:44 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b942424d231so175615166b.0
        for <linux-modules@vger.kernel.org>; Fri, 06 Mar 2026 10:27:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURIe8yi5zEFNUQB0U521MFbit1gO6x7S8z/K1i2acC7ech7+8J7fXO6p7xroyLWCZIh2m37KZFFJH1HINl@vger.kernel.org
X-Received: by 2002:a17:907:72d3:b0:b90:8016:cfe4 with SMTP id
 a640c23a62f3a-b942dbae36emr189809666b.10.1772821663491; Fri, 06 Mar 2026
 10:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org>
In-Reply-To: <aaroReSCj1qXUeQb@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Mar 2026 10:27:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
X-Gm-Features: AaiRm50t8TjmDHmMBt5Sh-GyOL4xotHpUKagWUMEUHoG2sdTM--QAxb3FwfabmE
Message-ID: <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 06:44, Christoph Hellwig <hch@infradead.org> wrote:
>
> More a comment on the previous patch, but I think exporting do_exit
> which can work on any task is a really bad idea.

What is the advantage of a module only being able to do
kthread_exit(), and not able to do a regular do_exit()?

I think the only real advantage of having a "kthread_exit()" is that
it's a nicer name.

Because if that's the main issue, then I agree that "do_exit()" is
really not a great name, and it matches a very traditional "this is an
internal function" naming convention, and not typically a "this is
what random modules should use".

So kthread_exit() is a much better name, but it basically *has* to act
exactly like do_exit(), and adding a limitation to only work on
kthreads doesn't actually seem like an improvement.

Why make a function that is intentionally limited with no real
technical upside? It's not like there's any real reason why a module
couldn't call exit - we may not have exported it before, but we do
have code that looks like it *could* be a module that calls do_exit()
today.

For example, I'm looking at kernel/vhost_task.c, and the only users
are things that *are* modules, and it's not hugely obvious that
there's a big advantage to saying "that task handling has to be
built-in for those modules".

So my reaction is that "no, do_exit() is not a great name, but there's
no real technical upside to havign a separate kthread_exit()"
function.

If it's just about naming, maybe we could just unify it all and call
it "task_exit()" or something?

           Linus
