Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66C3D647A
	for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688743; cv=pass; b=tcrfo5bvVae+5htNlZDrvtpgTG0elyreJ99ge/kYFIBIlSyK+cj7pkiYa5xw+rMgUzloBIbtIy6C2crkxi21juqSz+BU2fVvbsEKLXX+2ZkgCZFCbfAhp0RnoJHpKiEI4eO4rSZAWXmYLJgD6SWn04E/IYdM80xxSrLgyjwhOYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688743; c=relaxed/simple;
	bh=CF2ikandtVIT1owgnKtwBk+vrwZcicDlI2rfdeet7vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBNqlvUL+u0ayzyAJ8cpP9dqir6f2/+EJkqK/44ntsuNZWBGDnEFp0cB+tB7Gha+UyfJmbZwGwq1NSQlyCdpOv0Z36uV4Auf91VE6QY5wGvN5SQenvI9nwXJtK8lHcUFyZPZ9t2ox5oNJXr/fRPaURt2JljlldeZ4oQ2WzJHsb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/8F5E0k; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/8F5E0k"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bc5fa5a2aso130079eec.0
        for <linux-modules@vger.kernel.org>; Wed, 17 Jun 2026 02:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781688740; cv=none;
        d=google.com; s=arc-20240605;
        b=L+nI+ofFNJR3NnfhvS9FriL9/jtJlrYjh197AId0DpYKOemGyXBZouHd4pIN47MfiE
         r+FbrryEGwVvfaXMDJWpe3Ln+poL7KAPB3rTJWlFlKzjJBoMf+5TrmByQM1Vq8cDM76f
         gSJDxWNxSRdWviIBkG8TnzubiDrnT88NJgLyWPlxm+vq5T9bXhEptB2uto1oWpZ4xRR6
         6feVyj406X96jIGeUYx0lKQVS6m1seIaFNxgJ0M1RsDfb+ZJIHjKGiswtFN6QFCSDNxK
         IBE+DCzDYwoLvA7WE/Z2i3sVKDwaGYq/lu79EB4GwfynwEZDgDO1yrt7bAdvgVKYPqqk
         IAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+M2u0whYbtR605n6sG4R2CUdyrK3ztIkie7LjFmQ8N0=;
        fh=YoEeCQOezIq9OsMPxyldhehuzlGnz1HH5Zr2I7nrafk=;
        b=C0YKeNyNQS7hB6y9c/ucE0eq53ky3YCIhzznNFOOTf4eJdrdvOoDu/cV6r9d/O5Gh+
         VPm/d0/KiwI6F08iZ5JCbL4BB3CDQmaQ2oz9Zj0XXan3dsswhY8j0yktBWzluVRVDtiJ
         hWV9oXZFkOWVaBA2zPqWT72ZfPLwfQyUpd+Aski3XCde4ADWCsfpfXYA9cfUi+GdBMRM
         VOV4EGIZiwO0BbF+xLW5XCYbYItU2prYA+lp64lEV40BSYXWJ/qRGlhELYZi5vr/KzoG
         NnwcXA3x3fNCdXd+nFsQMjY3sTxdbt+OATBD4iO0vIW3vy4RezUYDLxACB+0JRfBOzTZ
         krGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781688740; x=1782293540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M2u0whYbtR605n6sG4R2CUdyrK3ztIkie7LjFmQ8N0=;
        b=G/8F5E0kZfsdROR+CtlTQ2tv4rDzjWtyQN+AGYvPHtdr9XY9qy7UYwZE1hrPDkUVlk
         ATgkj26J9kqLtk56XA6FnHSy5L4k/dkUm5Ogh72X13Jzh1RHxgn2JXD65ndtA2rCz8d0
         puHq46jG+pIyQHrjzFiSizmniDMZKihAdr9cBWcU3w31jrTYmFyLqSOIOZVmEa3D9Yrz
         oy7Id0tibTmRPqxtOMp9lEFdq16zNzl/oZCWDJJck8B278PgjASTaFzbqH+qM5zNCwRO
         bce4fOM1lXvQj+PJRekDPQJFUJs6eT/2JuFqyf0tbhMswKLqMcAk75QDIf9QJhPOzNou
         qaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688740; x=1782293540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+M2u0whYbtR605n6sG4R2CUdyrK3ztIkie7LjFmQ8N0=;
        b=fqD80ix3UfFp8j5MVovmhjwbg5fcsLMRC/9/QARg0k5z7NO7RvvgT7TYrhrSjGmlCR
         Mf9CHIZf2vz7LRreOJqL6H12XAfXluvg2xubMK1XL4P8gBupLNW0os8j8/K+ly4hEwXh
         NrKqV8hnIZ3mtAj9lLI8cNCx2Z9kolNKi9p2kVMvtQXaw694oJxUurxcLCRQaSoHT3+L
         fece8cisN9a3K5iC5qTk7WsziZtLn/s3JAPn6Dmgs73Vth2Y3nw0KBbPejos2Vn0Wheq
         EnX1r7dz4OvuMZ4OUUD3G1ADnJeSgUkvleqFnzOEgVyUK0Xcn210qP8OXHdgJMWUuONQ
         HF3g==
X-Forwarded-Encrypted: i=1; AFNElJ+fh24RX9carpnaIRCtClxtofhVN/Hqnzyhskp40SQiAwwF517UqOjBk6rU0QZZUHa65pYpqX+KTBe72U51@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsu574O4ieuxPwCT7QWf3aEjR8HHG2LqSchEH/0a1Kla/g0hEy
	DwWI9uLOgtUaGrBwqlWazSjPzEdqxu2uI9b+57AamUuRJ7s6qufzwmwqubaVb7T5ZDywaw3viP7
	rP2lAvNAVTxCQbbGvkaq00bIR0sZjhZU=
X-Gm-Gg: AfdE7cnrfqoMpGwuwOnfR5RHX1mKZvWNrDcVbos7JqqlzTEDkAG3ouapyCTEx5raHDT
	QOBQl0xBrfFVICcO7F5dpTLgFL6wXEgl+yu00kztjFBV6Ob1LZcdmYN+3mkMnwslP3YiqUR1KDr
	BBIgTTLNBAMXAxTqqAPoKNFCmqmO5ojTGIgidShn0xseX9H2bz2qoV/1PqmqkQTtyaLWl2BeSSs
	9I4WHCbIU9N5qoe9xCxhKZ6r7xiLh0cLR1fjj55sXCJyZ12nTKQJQ4MzvFSnbN3jnNnLbSs5p2k
	uupNtuIniM2ye/OG8JMH/pncY0nRBPzxwkOtxmwO3YIuXiYvLEbN7Mi+9VjLmtgr3ufiuH7yFep
	ir0Yd1SxzCkAi
X-Received: by 2002:a05:7301:100b:b0:304:c73b:79ea with SMTP id
 5a478bee46e88-30bc9f179cbmr752260eec.3.1781688739625; Wed, 17 Jun 2026
 02:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
 <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com> <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
In-Reply-To: <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Jun 2026 11:32:04 +0200
X-Gm-Features: AVVi8Ce2KN7fJSDwAaIQQF6892I0cepUA61wd2hQu8bQ0ZSAIWDKWJ48saLTpEg
Message-ID: <CANiq72=fUuX7fF1=AQ12ahYHwW7k2i28Hkpo0TtUhwV7qeojQQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs attributes
To: Malte Wechter <maltewechter@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:13=E2=80=AFAM Malte Wechter <maltewechter@gmail.=
com> wrote:
>
> As of now doc strings are not generated for private items in the macros
> crate. I am moving the `parse_ordered_fields!` macro into
> macros/helpers.rs but this means the doc strings are not generated for
> the macro anymore. The `parse_ordered_fields!` macro is a larger helper
> function, and the doc strings are relevant and helpful for macro
> developers that wants to use it.

If it is private, then it is what it is, don't worry about it --
developers can still read the source code.

But, yes, having a render of the private items is something I have
wanted for a long time, but as a runtime toggle, so that it is easy to
go from one to the other (and without having to have 2 entire copies
of the docs).

Please the entry "Private documentation (perhaps as an extension of
the private items/fields toggle)" I have at:

  https://github.com/Rust-for-Linux/linux/issues/350

Upstream `rustdoc` implemented an MVP of the idea via CSS/JS in this draft =
PR:

  https://github.com/rust-lang/rust/pull/141299

If you want to help on that, then you could try it and leave some
feedback there! :)

Thanks!

Cheers,
Miguel
