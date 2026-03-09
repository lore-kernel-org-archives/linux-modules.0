Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEE3D301A
	for <linux-modules@vger.kernel.org>; Mon,  9 Mar 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077298; cv=none; b=DvoPyT0nuGxEipEnbZNC2jYSpoQuV3roSGx456606+BuAYxZbaXn0PON+/Uq27ksPyPSOUfjAl1h75oMoz3C/ECmXScuumA1RmW+RACDPkRaGMFLQq214iEUbjgul4gSi028Ups6DkB2mom6nIvCEIMl+aCfHYn0Pmj2M5Ocb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077298; c=relaxed/simple;
	bh=LcKBSGkUJ4jOZjfNY8MJfZV+UOABBnNyslHE4iTDcoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYSx21MqMuO5vCdFqyfJTuSLVQYsAWTgJnHhEVSDYHmlIer9OMzl/avk/qYa7sWSnENUD4wkvzdyYrxXTTjwynoKkKYgw2TndT6tRw1/shxilm1zVWhLytBoWA38wL4H3fjfP4PcKQQmCxK2swrAKQQgMOl6rxaBdsn4da8s0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GLxT0H3x; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLxT0H3x"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6615c766e60so6820309a12.3
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773077295; x=1773682095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/0fgmHhC0VOep6ZWbqzX4YfecogO4RJ08oTSaCn8/k=;
        b=GLxT0H3xHna/5poGFHNUoY7YZB0pFj59+5ancojwDd8hEY6CBDtRK36DxbMXMpHPZI
         WC4l2UN2/ObYwq2jno0zBVygFhEh0AXN4QLCChqfdKx+7cHHAdKNcSST9V0kT/nt/8LI
         Ra8iWKajawUQJYkz5zpkete6udhaKp3m5eElk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077295; x=1773682095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/0fgmHhC0VOep6ZWbqzX4YfecogO4RJ08oTSaCn8/k=;
        b=AjmrJ4KpQzKRnIkq2oyh5BikvqNUh9SH4tG4TxZDrKJFCR4tp0ia3wA43j7oJURPaa
         VBhDpopyGqIsjdryHgVWBJeMXOKz/ePFEwc9Yw76RC9RCaihsBGI6xIKSE1YsZDg2wKu
         1TxtrN805RclekIhsNb/kQ112ms42p6NMxgcv3RluxQG5yYZXc9sPPW3ckebjHMWBabz
         dYCCAPvDt3+Y35xvbFTmuNlY45CqIISRh71kVBSLuxUFzwUcj3OMIyMEmUJW4oy+eeCT
         nra7oy+QUh7wEANI82YhlEfZ33pxaUXHQjEOna4OcU4kTvJRIs4AKUMS/zgyFtDMyzdf
         KXkA==
X-Forwarded-Encrypted: i=1; AJvYcCV/RWEp0Zui7WpY1jQHosgyqfbImePSxHw7BjlJaCccBIO1DUvF76QuDNaVr0iLd7K2dWwHrWaZfa6PIkec@vger.kernel.org
X-Gm-Message-State: AOJu0YzkA0VMrk5SFnuuXdMoluaQMsJTjyW+gIH5QIpTrVow+tMab4QC
	yrI4D19ZgruwZDvKBliKiqjZJi7rjEdi+czecqTFIho9rC8wzBfe7+KmjMzCLjv91QIbxa4P7td
	Ruxws+oM=
X-Gm-Gg: ATEYQzx5UmVfX/SBbPgIdlQBLtwbkdNbHtmGEUVqembXuPvr24O2fcf9YVAN62Zmy7+
	UW0UJeEIJc8a9mmJJ9juSJ8TNNTD8arjsc8c2T9Oh2hcmOc1Mbj+u4pX4h0EAd4p3qJvnfBkTqv
	SKJ1C7SItUjdgdusXbuFpqMyU71YiI8Jp58kR27ShmmxRvfrTaPXWP+tRTLRZaspTMtDiVT+6Nj
	1H+if0mJiy0SEuCXw4bKDr+7+ahRYbGjGB+l79oWPCk6J27u0WErJcNWaSsxoGBZSD7hJ1q11HW
	/hDaOzlesu+LixHJsG46/lGY3qqAdO4IaGgkQ+eJkgzpsLS5znKKeIr6NunIJu2tEmfm5f9boLn
	X5Bkbm0HlauxEAOzd1bPg5sgG/hrsZM+0PDteDqBkT4D+yDe6NWsn+PXeYKuYYw7VaAu0NCrEtU
	XfT5TAi78frrogK//9vy84240nr7Jsxjuz83OWkER47/AC+pDevlvymv76MXWxiHHgZFcgfkldb
	on8Xkur5pA=
X-Received: by 2002:a05:6402:2683:b0:65f:730d:8010 with SMTP id 4fb4d7f45d1cf-6619d45a03dmr6770584a12.3.1773077295226;
        Mon, 09 Mar 2026 10:28:15 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6629f7cbc78sm690286a12.17.2026.03.09.10.28.10
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:28:10 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-662b933f8d1so384786a12.2
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 10:28:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsg54e/fYmaahbQMivsahR4IUY2qx3PN9aVXuhGGbShilRUq94qWHclO2Z+ek+beH7WKyCHrOzMdDWUBOw@vger.kernel.org
X-Received: by 2002:a05:6402:50d4:b0:65c:23f0:a80d with SMTP id
 4fb4d7f45d1cf-6619d4e3738mr5814793a12.19.1773077289768; Mon, 09 Mar 2026
 10:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org> <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org> <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
In-Reply-To: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2026 10:27:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-QpnBHMH4Oa6tsYVhp+Uv+hKU_oedAUnt4icMqwPtzQ@mail.gmail.com>
X-Gm-Features: AaiRm50OcoxR7YXKVzqClnrYq6PJcpS66d_jgF8-UVsQY5IDs7VWWvYFcU4JSa0
Message-ID: <CAHk-=wi-QpnBHMH4Oa6tsYVhp+Uv+hKU_oedAUnt4icMqwPtzQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000000491e3064c9abac4"

--0000000000000491e3064c9abac4
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 09:37, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, there are real exports in this area that are actually strange and
> should be removed: for some historical reason we export 'free_task()'
> which makes no sense to me at all (but probably did at some point).
>
> Now *that* is a strange export that can mess up another task in major ways.
>
> [ Ok, I was intrigued and I went and dug into history: we used to do
> it in the oprofile driver many many moons ago. ]

It looks like it should not only no longer be exported, it should
actually be static to kernel/fork.c. As far as I can tell, that
historic oprofile use was the only reason ever this was exposed in any
way.

IOW, a patch like the attached is probably a good idea.

Somebody should probably remind me next merge window (I'm not going to
make 7.0 bigger, and I find examples of people using
kretprobe/free_task, which *should* still work just fine with a static
function, but for all I know if the compiler inlines things it will
cause issues).

Or just add this patch to one of the trees scheduled for next merge
window. I'm not currently carrying a linux-next branch (I actively
deleted it because it caused problems due to messing up other peoples
linux-next branches, so if I ever introduce one I will have to come up
with a better name anyway)

                  Linus

--0000000000000491e3064c9abac4
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mmjgdgcc0>
X-Attachment-Id: f_mmjgdgcc0

IGluY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oIHwgMiAtLQoga2VybmVsL2ZvcmsuYyAgICAgICAg
ICAgICAgfCAzICstLQogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaCBiL2luY2x1ZGUv
bGludXgvc2NoZWQvdGFzay5oCmluZGV4IDQxZWQ4ODRjZmZjOS4uMGVkYjM2MTA3YWM1IDEwMDY0
NAotLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaAorKysgYi9pbmNsdWRlL2xpbnV4L3Nj
aGVkL3Rhc2suaApAQCAtMTA2LDggKzEwNiw2IEBAIGV4dGVybiBwaWRfdCB1c2VyX21vZGVfdGhy
ZWFkKGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpCiBl
eHRlcm4gbG9uZyBrZXJuZWxfd2FpdDQocGlkX3QsIGludCBfX3VzZXIgKiwgaW50LCBzdHJ1Y3Qg
cnVzYWdlICopOwogaW50IGtlcm5lbF93YWl0KHBpZF90IHBpZCwgaW50ICpzdGF0KTsKIAotZXh0
ZXJuIHZvaWQgZnJlZV90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKTsKLQogLyogc2NoZWRf
ZXhlYyBpcyBjYWxsZWQgYnkgcHJvY2Vzc2VzIHBlcmZvcm1pbmcgYW4gZXhlYyAqLwogZXh0ZXJu
IHZvaWQgc2NoZWRfZXhlYyh2b2lkKTsKIApkaWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tl
cm5lbC9mb3JrLmMKaW5kZXggNjUxMTNhMzA0NTE4Li4zODVkODA0MzJhODkgMTAwNjQ0Ci0tLSBh
L2tlcm5lbC9mb3JrLmMKKysrIGIva2VybmVsL2ZvcmsuYwpAQCAtNTI2LDcgKzUyNiw3IEBAIHZv
aWQgcHV0X3Rhc2tfc3RhY2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB9CiAjZW5kaWYKIAot
dm9pZCBmcmVlX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCitzdGF0aWMgdm9pZCBmcmVl
X3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiB7CiAjaWZkZWYgQ09ORklHX1NFQ0NPTVAK
IAlXQVJOX09OX09OQ0UodHNrLT5zZWNjb21wLmZpbHRlcik7CkBAIC01NTUsNyArNTU1LDYgQEAg
dm9pZCBmcmVlX3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spCiAJYnBmX3Rhc2tfc3RvcmFn
ZV9mcmVlKHRzayk7CiAJZnJlZV90YXNrX3N0cnVjdCh0c2spOwogfQotRVhQT1JUX1NZTUJPTChm
cmVlX3Rhc2spOwogCiB2b2lkIGR1cF9tbV9leGVfZmlsZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
c3RydWN0IG1tX3N0cnVjdCAqb2xkbW0pCiB7Cg==
--0000000000000491e3064c9abac4--
