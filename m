Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA146455612
	for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726821; cv=pass; b=MUvIr7UcazxImQJY48TJfM1oq0Yt1gbvac/zjIn1yl5BMv7cHtU3r3VPaU437PyMRHvOjN+w/+daT1969/PyzL6br5pFrbSSjlPKdlWShwdwoqjrYx6U3k3XgQS2/tyqFQ3jQSb06+zugZawKVBtMCHMrnhbNdTEJTWLU1/+Eyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726821; c=relaxed/simple;
	bh=OBMgnNwbLIUmOMsL8sUSTbTR/61EiCyt8GG/HSPY+Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa4venUfIlAZnHNcLhgBl5uBIM8RmGEnDDEcxMRdrt5jX9DDwMiin69bgzSxZDqc7PA007QUiNFmR3S9edSmAoTN46mCPn8TKSVSye8feWpKwiJraOVk+wRLIuU6+DfYCQHXAfECa+DgdREvdpav1BkTjFQlqUXY0vNyohpbWQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH+Pe/aU; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH+Pe/aU"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535aa147d8so58612eec.2
        for <linux-modules@vger.kernel.org>; Sun, 11 Oct 2026 06:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791726819; cv=none;
        d=google.com; s=arc-20260327;
        b=E/JmEzXp3jlEZRXOxeyBLIHZUh3486T4Vk4IYZuQbkDrUpdS2UgLoKocfyyRwE/ili
         EMiEkR2oi5oeTpZ7KIcQ0LlBCcxWMEJAiqLBy4khvCH8SGalYQH/erFFc17D5uSWlDWg
         nloQ1BuNPKYx3pY4ko8yFoM2htGpN4kOZpk5K9Kzb8kjju0GvRgOU6bMqiNj1CPoZuZu
         x+UP//GoUxL8XENcHI6AljeSS0qEx614tswdL3BF9JnqQfIOWD+YZ0+0vyecShwM683A
         YGQGvg4xtrhuP2dgmqeOk+Tvb6fIv6WaG6Hc2STTHdCZzyWMKxIqXveH6N7x/pVR6xo2
         xUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OBMgnNwbLIUmOMsL8sUSTbTR/61EiCyt8GG/HSPY+Qc=;
        fh=+DxSYWveZxMzMKvTx8yuLqnEIRkfmH9STYHZsq6+lhA=;
        b=lbeqfX4TB1iJjnEVGbK8AFAyjfhitF2ifXwZ+4NlsrJJ/0k6AFCCPRllM4zqkAkFcC
         WKl9KYpXxYShFJc2fR1RtDH3vMKctHN8aFX1q2iCK1YzgziVqUGYacVyVXTNcrovk14q
         wrhdEX1zFimjoic3fAwZq8mrMAO4ZQToFtc+Q2ksVss5T3ZrxVaJLDRgX1xElHevTBdD
         bYox0tWbPkbNp3/oM9E7diMP9EEZYtiugtrf4ifQ15M+1I+SUaTVVnFMoy1fBNUb0rEa
         qelhY0AKcqn+LBWpohz/LZcj5ozaIxBcCtHo2Va41Vdlye3TKHABNoEIlv7iaFPQUJ/1
         aD+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791726819; x=1792331619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OBMgnNwbLIUmOMsL8sUSTbTR/61EiCyt8GG/HSPY+Qc=;
        b=SH+Pe/aUfQCWst3dbXchKKtAUo9gEOwW1iCr+xG8aALurikgr0hIyAaO+toqveQtob
         xytSX0OdTcb6mm7t2vOTFboCoP5Io5tf1mM0lE0rnMDveRdaoG9Geimn1U4SKM0dhxUz
         ftD/e8eSiUHkd+H5U3au9qwox2T3/5IvJjuKCN04VIkqF/UKV3zbV4x80To2IfeJNt4n
         98YH05Lv7WFKC9kaufq3kUo1uIemXxhFf+8WdJO1jZqlUkFfD+chaCs7fAQon2I0ABVZ
         Mop2GTVl4Grx0MaLllfGhqMT8QFmCgaMWsAAZA/qDd7wgU8KHDzoVEdsaP3Kj8UFXVDq
         1kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791726819; x=1792331619;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OBMgnNwbLIUmOMsL8sUSTbTR/61EiCyt8GG/HSPY+Qc=;
        b=wJXZwlzcNyI2krHtdVLbGVva9WlbmWp5mjm8/dYp6qW4nLBKVklBOkSuTGJc+DFv3p
         IiJ3CjTsdYq9akf4nRbFFwLGpeY1EXdb2thJdbk51nlDF8LJtlwjvc3pP798nb73b7/I
         R+c6z6XtajF0wgB+RNClrULlg2AWmWA74Kp/8mncXRqopZo9hDnbgLwPd3jffI6ZsNwI
         mr6jAwmqoz1LJllOxKO9XpSrs3cF90lNmgo9GSYCnAcDhdBavYMg2lwHRLtkDpAbLwIM
         ztA0xfzeLhnKAF5gAlgKvByt/R9MwX3emILBxyjH2Kl5bDBo5wCxFjzJq5rIA2jmEmh6
         XReA==
X-Forwarded-Encrypted: i=1; AKwUvBxeoCKWhcCzMq49yuqkaR/vrvOOt74e35Zf9ykySaf4rOjvAEt3VgEwOALh6NRQZV09KybmLHd2+LBLNJN6@vger.kernel.org
X-Gm-Message-State: AFq9FYJj4cLnG+Mjv3UCNHbb60/35ZpliUVcpFKFbYsstGgHKEtvn0Te
	kBpVGHYNJTwxnwDK0+IizqF4Gx24rQQg9MB1/19E21Yhv65OLuW1xQgFGSaq6PWOY7SipZl2wcL
	DGD0vmXFCKMDMVGoCWnP3Lq/rhaMSv5E=
X-Gm-Gg: AYBFou0KqIQoiU1Kd31QvEz2+Scj++xO3qmIZ/gs8wPwyMnNrUy6/BLeIzjoijlgXVK
	Cc56BoPmLRLiDLjWijCgQkOOqdmv94PDQNqbC1ncTxCIKSImyKG4Wbr7IRnbKFpEmKkvOqkGQuD
	gqKsYt05FJlYtm1HVsh6hPd6Khmi7Wp9Xdt5j2tE+s0/pOzkay2DhDT7anEDYZALGytGI/iufBK
	TbsC2sT0ZBKIZvo5zHlOS0iDhJJS/jITtCsIJ5EGZHejivaeph5hA1KBTADh8xLyb5nDpOSxqJi
	FIX78bFfH7OoMTwjv6E9mXpxdhCMniniTO9v5X2LAMQkZmI8uWdiPfNd5bneqJyB9j351Lggv6J
	Xo3ep7JJvslP7GRefI+YEZP5AmfkHpUTmMH8fTj2HKiEMTs99850RaCHdsTD/UHS02SsKhBhJSb
	+MmUWURFlKOw+kWw55gOWRbly8tMhKHlmHbfGtuTWuEpsPMI43+HY=
X-Received: by 2002:a05:7300:c8c5:b0:351:7e15:9c59 with SMTP id
 5a478bee46e88-3537dc89f58mr15242775eec.0.1791726818852; Sun, 11 Oct 2026
 06:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net> <20261011-rust-dyndbg-v1-4-832e4039b71f@weissschuh.net>
In-Reply-To: <20261011-rust-dyndbg-v1-4-832e4039b71f@weissschuh.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Oct 2026 15:53:26 +0200
X-Gm-Features: AclHuK8cVNPlyOorjrRhhdDkOJWkbQbDeGyNyJbJMfzEHu0iyDdJ7u6MM6NTRQ4
Message-ID: <CANiq72nN-X6pZJ8NhUOyLtXNPJWgh7oA7-kU9KaVnvjv-u1gOA@mail.gmail.com>
Subject: Re: [PATCH RFC 04/11] samples: rust_print: add debug messages
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 2:53=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> To make sure they are actually printed, enable debug assertions.

Hmm... why do we want to make sure of that? i.e. users can configure
the debug assertions, and the sample may show them if they are
enabled, just like any other code, no?

I guess you may want this for e.g. a CI, but in that CI one ideally
would test both cases, and assert that the messages both appear and
not appear depending on the case.

Cheers,
Miguel
