Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881C3392809
	for <linux-modules@vger.kernel.org>; Mon,  9 Mar 2026 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074268; cv=none; b=mycUW8LCfWIO15SXNdUteST6XNY8dOvDX5KiurL/0FURN1qSieUxGD+HFEebmOzlcVbcLScB7jece74EDOcqP3j0X25MG5qIUInsxz/XgZvTbA01NeU7OOPPkqkhWPE55iHJvOjrlnVgsi+DcgRnSlKzTJQSoXbHSdp+eAFR3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074268; c=relaxed/simple;
	bh=zAR72wDXdxq5C9PjPsyeD4QQxyEK/1hXtEl2Xpss9d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1/mq0zq/MUpedlw/+Xcb4sJiXZD6FNCu7RXHrxDt/HwqNcoHEhhNXqmJd0ZiCNjsVgzRAhpwGjdHLhLj/6H0XT0F2+hlSWiGe5j44/4/gQ2k/KEImSY0rcq5GpwBxOgyfFPrxn2sUdSfR3ucJNnZyRibyvrk95fOFRLjYoKuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OUhtxiZS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OUhtxiZS"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b96dc65b886so268308066b.0
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773074265; x=1773679065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5aGclf2D5Ad+FZRYNo1Igm1i3XSKWX/TJgjzbw+i9o4=;
        b=OUhtxiZSd3fD8FxP+CuE4U0ccCfq7SOwWFEhdCB+UEgRzQUaEGzJPNaQDR5lsgMKsL
         Uuuv/UpvTmmFdKL+0ntv/JO9wNRv2fid5tS9ClAs1jOEPzbeurnUF9aWo36gYY1Jjaue
         28AwxMzUEi5C5fChkIRODMwKx4acJeAruEVpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074265; x=1773679065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aGclf2D5Ad+FZRYNo1Igm1i3XSKWX/TJgjzbw+i9o4=;
        b=jKaFm9CivUXkEzAwmgOivRLIMJlXdmi319d5/TvQrgneXKZRk9Z3OEfAiE4ilK5cnn
         qq9YDIYH+bhxImJEqWIHu2SpSKqPlFJH5y+k2ROKA10x00oim2tdDdMSv3690CxFPnqd
         o/RCTGez7bBrO+7ft9FIY5ciUThasVNLjwPesyvTowLzfTcFp8hb1XsPye30Bu3CnDbW
         jnU3eFphvkJ+/hcuBAJ2iJzf5NjzRS2No085mc5lP/EWvTaRogMKQ3vpuaoJZt/cJ0Er
         SixjThsKr1tdxxAYiCdZUUA82Q34UTHQvoe+eyHosFnv1sinERhSQPMySQ/+FG6K4PEr
         ntJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTgLwZBT5AM5qgUs5HqoIW4XWw8MpJljcWkawKpMaHMzbeCl3VuYJUvK02YEF8OFEMY/2A/wsQKb5lTi/R@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSZkUe8o1z7R8adf6DUG8qMCa9w2/fVSUMDQy520CwDDZOTj4
	D2ahyue7LaLG3CKxjZR3zdOziZrl/FgTkZ+LTgMNYmRDhzPL0U6uNoZLXmIEODkR8yhx/coJR/T
	GRBUWbbU=
X-Gm-Gg: ATEYQzz1I2LMpH0Lt06B5tbzDfgdcPD0+eDiI6Z/tBMspmDg+TNa+za4z3aLNn+W1RU
	XT+EQ7G0lxW2x4i7c2k2Nf66nFrxkE09s0QlBsnJag+7SLey5Gyn+AnnL1LJ5OU7qQk9AkFLvN9
	IIe3IfZrgNKfASQnfhcM1o0MFnu3JcfAVDq7ODNPmnKx9VTohGNKDsFG2CpRPv4CIQ7fjUigLqy
	z0HKk1NpjkK9sel83XZ9U+DO9hifcMIy4yAuPkVMvoOwZzAsaJz3UEV5h8xG8JpeMOxVrXCkU3q
	2bXdtLEZbBw8sycsRwx4fDzj2PfSVOTk7O9lzdlO7zQ6pk+f5eetWF6ng6t2He/aSFJzD+wN6Aj
	GT0E39VRWcx3YimKCcRzQGcqvfPOnz5CZkr1JvPyTZAK+JBf3VhgKU1MJjrqvOnFvjSf+jUspr3
	HDmL9h6nra9fpa+ukuVeFUpTxI4qKBZT/kJlogwINGpJQmbQqyFls0/lCNzvfhVX0PoeiF9pSt
X-Received: by 2002:a17:907:9694:b0:b8f:de69:b597 with SMTP id a640c23a62f3a-b97118b83e1mr19060866b.7.1773074264697;
        Mon, 09 Mar 2026 09:37:44 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15d56fsm401522466b.56.2026.03.09.09.37.43
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:37:43 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9423d62cbbso455310666b.1
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 09:37:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa6RTr49nHPQZRXQV50QW+M5ww4bCvsEw7aQ0ioszI3Vdwul5S2S4kpcKX7dZeNmVB12vSKuSRP0Uap7IX@vger.kernel.org
X-Received: by 2002:a17:907:3e10:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-b9711a1fe33mr14904266b.18.1773074262570; Mon, 09 Mar 2026
 09:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org> <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org>
In-Reply-To: <aa7qson15uJpL-BL@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2026 09:37:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
X-Gm-Features: AaiRm52k8FmvIAxaWFSwelL44z7-IyhgZowK3grBWDh2zbSjeLnGfYwalrLVlLs
Message-ID: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
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

On Mon, 9 Mar 2026 at 08:43, Christoph Hellwig <hch@infradead.org> wrote:
>
> Because it can't f&*^ up the state of random tasks.

Christoph, you make no sense.

"do_exit()" cannot mess up random tasks. It can only exit the
*current* task. The task that is running right now in that module.

And exiting a task is about the least effed up you can do to a task
when you are in kernel mode.

Compared to everything else you can do by mistake - like just
corrupting task state randomly - it's a very benign operation, *and*
it is obvious both in source code and in behavior. It's not like it is
some subtle operation.

I'd be *much* more worried about actual subtle bugs, not somebody
explicitly calling exit.

So what is the actual problem? No more random rants. Explain yourself
without making wild handwaving gestures.

Now, there are real exports in this area that are actually strange and
should be removed: for some historical reason we export 'free_task()'
which makes no sense to me at all (but probably did at some point).

Now *that* is a strange export that can mess up another task in major ways.

[ Ok, I was intrigued and I went and dug into history: we used to do
it in the oprofile driver many many moons ago. ]

And since I looked at the history of this all due to that odd export,
that also made it clear that historically we used to export
complete_and_exit(), which was this beauty:

    NORET_TYPE void complete_and_exit(struct completion *comp, long code)
    {
        if (comp)
                complete(comp);

        do_exit(code);
    }

so you could always do "do_exit()" by just doing
"complete_and_exit(NULL, code)".

And yes, that function was exported since at least 2003 (it was
exported even before that, under the name 'up_and_exit()', and that's
the point where I couldn't be bothered any more because it predates
even the old BK history).

Yes, it was indeed renamed to kthread_complete_and_exit() back in
2021, but that wasn't due to any fundamental "it has to work only on
kthreads". It was simply because nothing but kthreads used it - and
because that was also the time when kthread_exit() started doing
*extra* things over and beyond just the regular do_exit().

So it was a practical thing brought on by kthread changes, not some
kind of "exit is evil" thing.

And that "ktrhead_exit() does extra things" was the actual bug that
needed fixing and caused nasty memory corruption due to subtle lack of
cleanup when it was bypassed.

End result: we've never historically felt that exit() was somehow bad,
and when we limited it to kthreads and made it special, it caused
actual bugs.

            Linus
