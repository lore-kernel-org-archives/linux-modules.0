Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CF2273D77
	for <linux-modules@vger.kernel.org>; Tue, 13 Jan 2026 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300439; cv=pass; b=aCeLnEIiXizSiTqk9I+iJUALWhXadnw3MX4rZsT30gN3lelWWZHh8IJA46DGCqN62mvCEf5/KL6t6NmUbN19DenN6rvBav7MlPfynwh3JqDMQKgzinHkdEh0tjPad8w2VWS1YrOCXmJybkzFhyKiyCIm3xHhc1Boq1Sft3zO6jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300439; c=relaxed/simple;
	bh=6wVoyLrqywcOmQmN4+r6RZ36ne1t081jgSFidw+ue4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHu1S0XMKdrOjfh0/BdvuDukjTfsnKfDjse1t9rQcQYApqBVnp2P3ThZdTNjh+jYVeyOeAh6dQuYFLzLxs+31wu9Fi2eZnx2UYhOrXJTx6eeKTm9ArulyYrzTY4Sx6vjuBy+8aBypyDBV0gihoV7O1ELYcNE/p+5wQVj9Xz909U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmZlv3+m; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmZlv3+m"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ae5283dae8so253617eec.2
        for <linux-modules@vger.kernel.org>; Tue, 13 Jan 2026 02:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768300437; cv=none;
        d=google.com; s=arc-20240605;
        b=UcAqltcyBXYkFaiq5XHyEVkm9slEzmNpstmZq5m9kGsvW9F7rL3Be7SKCT54A0ZXcQ
         ynTqg9YvPYSYU4hnW5bUTiGkK4Gd008xZS1uyegj7DWbl2FurYDAW6AtSXwLLUvOG/4v
         6+mCqj3Xnp9GJL/313HFkZjylHRJehLcWIOte3kTnWYwhOMJYRpWEGrzxBAwStZmhb9O
         bYlCSaPvO7nIQuxa3fjsn/DXOBCnunNQunOp7sFHKjSiipvdo1TJeXZFbuK0yt6bz/Vf
         6/rY7TiE4xw+8NmgJklkN1LEstnJaV+nQ/2FxRpRbYhSBI7+qQ1R2R1wjrz20OpmQvwZ
         JqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wVoyLrqywcOmQmN4+r6RZ36ne1t081jgSFidw+ue4M=;
        fh=6gX2Q4nJ2KAdL3jtbAHL1EPiwXZl1m19mSlnw1cd3S0=;
        b=ImYCYJ/GQUyA5sF+4YkEpNnFjrJh3Ys1PJECIb8SAfg34f6+5WFofKWLZar6VuA7xo
         8eJzRW3aGDu+RM3Ob3S6exynIAvwe6IgUwoQLUig/VqpnZWRBfKeNzZBWVTXmhEHEpSu
         QXt6gNKoo7Vss2S0zwcNPVZcmTMJcfCmNZTrP2iePOzTYekh527JoJZTFwob5To0A0PM
         HmePVcTpUd2qFRqwg+LUvoXLC62OCshVYmZLp/C+HyXMKWk1O3tteZ+dbW4xvy7wiuru
         V5Z1ZimPk9YdZF2FwisNyE3azsLb9dMRG7r1CNmRkdJiisf6HBVNeEH52a/mbLue2Tsu
         V+dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768300437; x=1768905237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wVoyLrqywcOmQmN4+r6RZ36ne1t081jgSFidw+ue4M=;
        b=NmZlv3+mXk5bSY8g3C4KVfhkw15lO9QbCi95ATgIw0NvDW3qF6mUyB6GDeuWNtiYsq
         Mw/sV00VtstCOaTJPnvjw0mgTnA3Amt+7f1IDzZOZw83GcNq0+UKVls6Jm+0mi7uesCu
         RYmAb3kqIEyOiTl+NEF9ZCi7To7CAgmnZGnn9wBcKNVlj5/3lvmXPmMfKGxaWYpBtf9n
         W0HyehpaPzMzJbsAWUVoMVptfHhEnhCHARRKh3LLRBucMbPdbHc1WTWCeT7VzFIUAZFu
         Z14wwBbus3J5a8H9ThnRGAJFryPNdHe2pyucnCNGrL1EA/f+FctxUZ9C9hPgZBtZC4jw
         Cqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300437; x=1768905237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wVoyLrqywcOmQmN4+r6RZ36ne1t081jgSFidw+ue4M=;
        b=rLOiu2zd+KWNZlTw9E4B2P9VKbC/lKB1m8NhGBEch3MA53lZXkQlDjXVPB9ADEvmzE
         9OUQ1XmF/iGhtN6uTTpt3E3IWsRf8lTMWWJVPmxHKuhAwml/peSUOUUawef6Qt2xFv1O
         e258p7yAvtTGDYxAc8jdtYdkLWTO8EuNTH9tpdJLOBelJ1zSUZ0vv0Navi8U/5KK5jwM
         Pl6lXDGPR+BpZI2ig8wr0h3AXi7xDt1CFIOueUef4Tl4aOaftozspEdT6DiSUdkWx1nn
         oNEQda5KYXQG1lMYwy8fdkD+lkGjKMMTFC59XBYvV0VRGp4oygoUmjmzYWv0pZ5D53VJ
         N0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWq6cmdKRN2GKbJA3rMwNZzg9xCalQPiQaUz4JxknZd1R20mvI36ubVfZw8kqWAY+vTzMI5WzcLhCOm8G6@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIm0LckGVFbegypZeu974Tnoiqe1LD6SKH3ABtUt4rrDLZ+jP
	fMrHZsMyV2+szAkWNA05P7Lv2lg7EzoHX/6+od3C0XSjRBkchLFL0PJFKylyZSZ6u6goXAHxu77
	NQIcPGhfuaI1DfsHHNqSSDIgaamW5VFM=
X-Gm-Gg: AY/fxX5kwoiF1tBC49bdvHzSwLuEOvSsrL0OF2dPLyBtCKCAxHkhPkW70dWLD6A3jn3
	yjCS0OBb+69WprPsADhPApT417D/JH+b4NfEjxJVS6CuzH9wFtL60QG6zGSCirKQnEolmJoKHBu
	8ltfH8rDrc7XQqtGVdDm7EwGYanlTmgtCu2W0mMjWqHej3CEPgS5VflCBkHNvG43yD5yev5Gcax
	dMX1Ez4jntYIGnYLE7KVWix7q0fAoFi0au8tGZUxJhZAAk8icF9XCfnAdU5BLJuW9dNwm8HG5mf
	rvsvtcJ6azLEh7dJAdYXmuAP8AslUEVE6VDQNgP9P2lwAKQOaYnDMfB+x9sjmPETcQbSNa/f2ts
	3IgcMAdALe12G
X-Google-Smtp-Source: AGHT+IGcAUwwHKFz29uCFuaLCHQFUBpfMMrhPILzRNLEOICzlrBTUuR090yAT0GAHICjPqdgNCbFvEf62i8h4sT8PoY=
X-Received: by 2002:a05:7301:190b:b0:2ab:ca55:89bd with SMTP id
 5a478bee46e88-2b17d2e3950mr6767186eec.4.1768300437056; Tue, 13 Jan 2026
 02:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-this_module_fix-v3-0-97a3d9c14e8b@gmail.com> <c2d900fc-5f59-4da4-9600-eaf6546beba4@kernel.org>
In-Reply-To: <c2d900fc-5f59-4da4-9600-eaf6546beba4@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Jan 2026 11:33:43 +0100
X-Gm-Features: AZwV_QiwMsxbaGb5HBUrEyx5hdr8D6vf9-O0HVOWNW3cjCw5cHgs53It9xW2U1I
Message-ID: <CANiq72k6fbighSnZVjWZRq_A07h+vg7Wp4KcH+2fKwn47shYDQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 00/15] rust: Reimplement ThisModule to fix
 ownership problems
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Kari Argillander <kari.argillander@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Youseok Yang <ileixe@gmail.com>, Yuheng Su <gipsyh.icu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:56=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> Shouldn't it be called this_module instead of ThisModule ?

The common Rust style, which we use in the kernel as well, uses
several kinds of casing to make it easy to distinguish between types
of entities at a glance.

Traits use CamelCase, like structs and enums. So if `ThisModule` is a
trait, that would be its case.

But, for instance, if it were a constant, then it would be `THIS_MODULE`.

Details at https://rust-lang.github.io/api-guidelines/naming.html --
sometimes we may diverge from that, but in general we follow the usual
style.

Cheers,
Miguel
