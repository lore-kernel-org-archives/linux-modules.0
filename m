Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CF335061
	for <linux-modules@vger.kernel.org>; Wed,  7 Jan 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805934; cv=none; b=qi/PB8Pjx71Nnr3KudCM9U/m9Kw4FD5xiXd27eblN9sfKz9bBJKp6WpYidT6MlJVMfBe0WwjKNjcwDdrEZnr/We8UrHvX3lQHl3ndkslac96ToWv9UuTgwcdNiYj+zwprdlk3LNcXaMcLmOwrybs+B/jfXGHSHgM4YPNp5G4tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805934; c=relaxed/simple;
	bh=qfiU0RP5rsBJfZLi9g/wWXlOIZsG/ffoZBFain5yVns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzMzUUzPbMOyDcqJBibgGIBhWlHh73ijeGYsZ+QXrxc+IAx5XVVTs786zw7d5UJWqTX/fknfEs8vka9lQR5donDnjxTXoRtLQcscjUb3zfkSLl8IoyO/ntLw4NV7N7EmdksaMrGB0Bt3TH0PlL+FA9IjLunk3cHycHXFad8JFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUWiy4vn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUWiy4vn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so1836046a12.1
        for <linux-modules@vger.kernel.org>; Wed, 07 Jan 2026 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767805930; x=1768410730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12rvxRXGEV107kbtHp7aplPR2hZlwXqAByxDzT79k5g=;
        b=BUWiy4vnEgmrBTVAophBOB8IAg08R7hYNzIG9YGgrD0PgugCAkpNzGoXS1BV4poDM8
         DdmV9/KSsvG8UfvOOkAuQrmwpcKW143lEWgezOnjBOOEFJ2NPQK+aRS+KLQLqWf6rM5p
         gjPxrEraIB3xDbOfuUNUW8p6cqYgmz5L4u5bQ6mMWTpeZFPvZhXpDvBYgH4Tj5V6HwLp
         onoUk+C0WlTRpsoM3UT55xmfAVA2EoHv0msOiNEvfoElelmdbNaY8padjC+IDyWE/tEi
         7+grLyT+bWyVLlYLPY66VxRdRismLt0AnNW5KrFj7e99NRk0VSgonp9Tw1+oFvY12hCV
         HQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805930; x=1768410730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12rvxRXGEV107kbtHp7aplPR2hZlwXqAByxDzT79k5g=;
        b=YDQTuaoAOFUtYQan1ot/lecTrG6fK8oMfGTRyxXz5bjUPPCwlFd9UNR7NdAfwehBfN
         /PJquyD3FDUPGJ+9IC9N0rfkrREHOkRXd4QE6m+W/IbOndZHE0mbev/Ln2f7vH95XzgO
         CLuTWnMsdOMm17HHfhUQVHbXb0DCS4ATNR0MQ8kQhpZpemiUlstj2IXARMf5QBCkTJ24
         Gl5a1W73Gk5C2rYsRYkJkUl1jUFPsE50eCTGQk3MMQXCUs3Isg2GbmzYVYwSFwPXAei2
         pvDSSLIafOkdg3h8h3dFjQuBSnALmoD67YNsLwIx8JgUR4M4Vur0XqsuRlggv94rGVKy
         pHkw==
X-Forwarded-Encrypted: i=1; AJvYcCW2rUxHhNA3rxlC10kOQL0qxJAO3vk+AyL4PzJ/edBWOj+QRaERbiysbt9e0ga1NgKpkqvmv4asR/3Bw/Jd@vger.kernel.org
X-Gm-Message-State: AOJu0YwGasXyLh5QfnIlD0ucHepIjE7HAeNi1sR6VOqExYFT4dVPrLhA
	WT20nfsAoZiumBxdDVYvxwyRsDpAzdZMQYhgbmPmZ/rlq48Cz5GhNbni/r80+DunfzknrCPgeer
	ci4VqHugxwNuOQXq7YG4KUFD4qtyub5U=
X-Gm-Gg: AY/fxX5ULMfVPWanCXkg7Kdjc24SyJN9JxL4F+/3JSb2RxZl0HQXC+R0qEK2CrSeeiq
	44WxfdNYpXmRGnbxnKWKDm8EHH2UukYJke7H9I0FGmhYTOKubbx7BXXGCf2Y5L4sr2TJU19xKQk
	fFm6Lbo70sXDxBa9ojxABhcgbsDgy2v16g1Fi7kCfaJRSUYwyp5yZ+7BICQXw3EFxOxglq0POw1
	ulqHWvCtqopn7EbFA8C0/H1VhO2C6IuYDUI+VHGqTHzNPCuDqt5iQ0ior7FfMizpclXGBtMujBp
	E0X2xiX53bwPU94z9Y2soYkswLGH9JEjCpcg7OjUV7NrGDlnthlvVJO6qsx+kEcAFF3JthLk9Ip
	Vjs8uwg==
X-Google-Smtp-Source: AGHT+IEF150itPPvkQjO5ra64ckLEwCbk2dZsCiaZ/RN969mDHH/M89p/2ozkymiLaO0K80XWorOlgl8i/UjyRCeQKI=
X-Received: by 2002:a17:907:97c2:b0:b73:9892:7f46 with SMTP id
 a640c23a62f3a-b8429b98008mr697754966b.29.1767805929159; Wed, 07 Jan 2026
 09:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107161729.3855851-1-gary@kernel.org> <20260107161729.3855851-5-gary@kernel.org>
In-Reply-To: <20260107161729.3855851-5-gary@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 7 Jan 2026 12:11:32 -0500
X-Gm-Features: AQt7F2oTPnssUczZmCEFZ9r-8ZAkvB3eU7xYsWR_4JTXJnBRyw9KK4Ik0waqA0s
Message-ID: <CAJ-ks9=2E0XV03ONKaeSnjq5fD=WC3u=nDnkmYK_spv59zVpjw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] rust: macros: use `syn` to parse `module!` macro
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	rust-for-linux@vger.kernel.org, Patrick Miller <paddymills@proton.me>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:30=E2=80=AFAM Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> With `syn` being available in the kernel, use it to parse the complex
> custom `module!` macro to replace existing helpers. Only parsing is
> changed in this commit, the code generation is untouched.
>
> This has the benefit of better error message when the macro is used
> incorrectly, as it can point to a concrete span on what's going wrong.
>
> For example, if a field is specified twice, previously it reads:
>
>     error: proc macro panicked
>       --> samples/rust/rust_minimal.rs:7:1
>        |
>     7  | / module! {
>     8  | |     type: RustMinimal,
>     9  | |     name: "rust_minimal",
>     10 | |     author: "Rust for Linux Contributors",
>     11 | |     description: "Rust minimal sample",
>     12 | |     license: "GPL",
>     13 | |     license: "GPL",
>     14 | | }
>        | |_^
>        |
>        =3D help: message: Duplicated key "license". Keys can only be spec=
ified once.
>
> now it reads:
>
>     error: duplicated key "license". Keys can only be specified once.
>       --> samples/rust/rust_minimal.rs:13:5
>        |
>     13 |     license: "GPL",
>        |     ^^^^^^^
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

> ---
>  rust/macros/helpers.rs | 109 ++++--------
>  rust/macros/lib.rs     |   6 +-
>  rust/macros/module.rs  | 389 +++++++++++++++++++++++++----------------
>  3 files changed, 277 insertions(+), 227 deletions(-)
>
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index 13fafaba12261..fa66ef6eb0f3d 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,53 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro2::{token_stream, Group, Ident, TokenStream, TokenTree};
> -
> -pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<Strin=
g> {
> -    if let Some(TokenTree::Ident(ident)) =3D it.next() {
> -        Some(ident.to_string())
> -    } else {
> -        None
> -    }
> -}
> -
> -pub(crate) fn try_sign(it: &mut token_stream::IntoIter) -> Option<char> =
{
> -    let peek =3D it.clone().next();
> -    match peek {
> -        Some(TokenTree::Punct(punct)) if punct.as_char() =3D=3D '-' =3D>=
 {
> -            let _ =3D it.next();
> -            Some(punct.as_char())
> -        }
> -        _ =3D> None,
> -    }
> -}
> -
> -pub(crate) fn try_literal(it: &mut token_stream::IntoIter) -> Option<Str=
ing> {
> -    if let Some(TokenTree::Literal(literal)) =3D it.next() {
> -        Some(literal.to_string())
> -    } else {
> -        None
> -    }
> -}
> -
> -pub(crate) fn try_string(it: &mut token_stream::IntoIter) -> Option<Stri=
ng> {
> -    try_literal(it).and_then(|string| {
> -        if string.starts_with('\"') && string.ends_with('\"') {
> -            let content =3D &string[1..string.len() - 1];
> -            if content.contains('\\') {
> -                panic!("Escape sequences in string literals not yet hand=
led");
> -            }
> -            Some(content.to_string())
> -        } else if string.starts_with("r\"") {
> -            panic!("Raw string literals are not yet handled");
> -        } else {
> -            None
> -        }
> -    })
> -}
> -
> -pub(crate) fn expect_ident(it: &mut token_stream::IntoIter) -> String {
> -    try_ident(it).expect("Expected Ident")
> -}
> +use proc_macro2::{
> +    token_stream,
> +    Ident,
> +    TokenStream,
> +    TokenTree, //
> +};
> +use quote::ToTokens;
> +use syn::{
> +    parse::{
> +        Parse,
> +        ParseStream, //
> +    },
> +    Error,
> +    LitStr,
> +    Result, //
> +};
>
>  pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
>      if let TokenTree::Punct(punct) =3D it.next().expect("Reached end of =
token stream for Punct") {
> @@ -57,27 +25,28 @@ pub(crate) fn expect_punct(it: &mut token_stream::Int=
oIter) -> char {
>      }
>  }
>
> -pub(crate) fn expect_string(it: &mut token_stream::IntoIter) -> String {
> -    try_string(it).expect("Expected string")
> -}
> +/// A string literal that is required to have ASCII value only.
> +pub(crate) struct AsciiLitStr(LitStr);
>
> -pub(crate) fn expect_string_ascii(it: &mut token_stream::IntoIter) -> St=
ring {
> -    let string =3D try_string(it).expect("Expected string");
> -    assert!(string.is_ascii(), "Expected ASCII string");
> -    string
> +impl Parse for AsciiLitStr {
> +    fn parse(input: ParseStream<'_>) -> Result<Self> {
> +        let s: LitStr =3D input.parse()?;
> +        if !s.value().is_ascii() {
> +            return Err(Error::new_spanned(s, "expected ASCII-only string=
 literal"));
> +        }
> +        Ok(Self(s))
> +    }
>  }
>
> -pub(crate) fn expect_group(it: &mut token_stream::IntoIter) -> Group {
> -    if let TokenTree::Group(group) =3D it.next().expect("Reached end of =
token stream for Group") {
> -        group
> -    } else {
> -        panic!("Expected Group");
> +impl ToTokens for AsciiLitStr {
> +    fn to_tokens(&self, ts: &mut TokenStream) {
> +        self.0.to_tokens(ts);
>      }
>  }
>
> -pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
> -    if it.next().is_some() {
> -        panic!("Expected end");
> +impl AsciiLitStr {
> +    pub(crate) fn value(&self) -> String {
> +        self.0.value()
>      }
>  }
>
> @@ -114,17 +83,3 @@ pub(crate) fn file() -> String {
>          proc_macro::Span::call_site().file()
>      }
>  }
> -
> -/// Parse a token stream of the form `expected_name: "value",` and retur=
n the
> -/// string in the position of "value".
> -///
> -/// # Panics
> -///
> -/// - On parse error.
> -pub(crate) fn expect_string_field(it: &mut token_stream::IntoIter, expec=
ted_name: &str) -> String {
> -    assert_eq!(expect_ident(it), expected_name);
> -    assert_eq!(expect_punct(it), ':');
> -    let string =3D expect_string(it);
> -    assert_eq!(expect_punct(it), ',');
> -    string
> -}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 9955c04dbaae3..c5347127a3a51 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -131,8 +131,10 @@
>  ///   - `firmware`: array of ASCII string literals of the firmware files=
 of
>  ///     the kernel module.
>  #[proc_macro]
> -pub fn module(ts: TokenStream) -> TokenStream {
> -    module::module(ts.into()).into()
> +pub fn module(input: TokenStream) -> TokenStream {
> +    module::module(parse_macro_input!(input))
> +        .unwrap_or_else(|e| e.into_compile_error())
> +        .into()
>  }
>
>  /// Declares or implements a vtable trait.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index b855a2b586e18..6ad7b411ccde4 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -2,28 +2,30 @@
>
>  use std::fmt::Write;
>
> -use proc_macro2::{token_stream, Delimiter, Literal, TokenStream, TokenTr=
ee};
> +use proc_macro2::{
> +    Literal,
> +    TokenStream, //
> +};
> +use quote::ToTokens;
> +use syn::{
> +    braced,
> +    bracketed,
> +    ext::IdentExt,
> +    parse::{
> +        Parse,
> +        ParseStream, //
> +    },
> +    punctuated::Punctuated,
> +    Error,
> +    Expr,
> +    Ident,
> +    LitStr,
> +    Result,
> +    Token, //
> +};
>
>  use crate::helpers::*;
>
> -fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
> -    let group =3D expect_group(it);
> -    assert_eq!(group.delimiter(), Delimiter::Bracket);
> -    let mut values =3D Vec::new();
> -    let mut it =3D group.stream().into_iter();
> -
> -    while let Some(val) =3D try_string(&mut it) {
> -        assert!(val.is_ascii(), "Expected ASCII string");
> -        values.push(val);
> -        match it.next() {
> -            Some(TokenTree::Punct(punct)) =3D> assert_eq!(punct.as_char(=
), ','),
> -            None =3D> break,
> -            _ =3D> panic!("Expected ',' or end of array"),
> -        }
> -    }
> -    values
> -}
> -
>  struct ModInfoBuilder<'a> {
>      module: &'a str,
>      counter: usize,
> @@ -113,12 +115,16 @@ fn emit_params(&mut self, info: &ModuleInfo) {
>          };
>
>          for param in params {
> -            let ops =3D param_ops_path(&param.ptype);
> +            let param_name =3D param.name.to_string();
> +            let param_type =3D param.ptype.to_string();
> +            let param_default =3D param.default.to_token_stream().to_str=
ing();
> +
> +            let ops =3D param_ops_path(&param_type);
>
>              // Note: The spelling of these fields is dictated by the use=
r space
>              // tool `modinfo`.
> -            self.emit_param("parmtype", &param.name, &param.ptype);
> -            self.emit_param("parm", &param.name, &param.description);
> +            self.emit_param("parmtype", &param_name, &param_type);
> +            self.emit_param("parm", &param_name, &param.description.valu=
e());
>
>              write!(
>                  self.param_buffer,
> @@ -160,10 +166,7 @@ fn emit_params(&mut self, info: &ModuleInfo) {
>                          );
>                  }};
>                  ",
> -                module_name =3D info.name,
> -                param_type =3D param.ptype,
> -                param_default =3D param.default,
> -                param_name =3D param.name,
> +                module_name =3D info.name.value(),
>                  ops =3D ops,
>              )
>              .unwrap();
> @@ -187,127 +190,82 @@ fn param_ops_path(param_type: &str) -> &'static st=
r {
>      }
>  }
>
> -fn expect_param_default(param_it: &mut token_stream::IntoIter) -> String=
 {
> -    assert_eq!(expect_ident(param_it), "default");
> -    assert_eq!(expect_punct(param_it), ':');
> -    let sign =3D try_sign(param_it);
> -    let default =3D try_literal(param_it).expect("Expected default param=
 value");
> -    assert_eq!(expect_punct(param_it), ',');
> -    let mut value =3D sign.map(String::from).unwrap_or_default();
> -    value.push_str(&default);
> -    value
> -}
> -
> -#[derive(Debug, Default)]
> -struct ModuleInfo {
> -    type_: String,
> -    license: String,
> -    name: String,
> -    authors: Option<Vec<String>>,
> -    description: Option<String>,
> -    alias: Option<Vec<String>>,
> -    firmware: Option<Vec<String>>,
> -    imports_ns: Option<Vec<String>>,
> -    params: Option<Vec<Parameter>>,
> -}
> -
> -#[derive(Debug)]
> -struct Parameter {
> -    name: String,
> -    ptype: String,
> -    default: String,
> -    description: String,
> -}
> -
> -fn expect_params(it: &mut token_stream::IntoIter) -> Vec<Parameter> {
> -    let params =3D expect_group(it);
> -    assert_eq!(params.delimiter(), Delimiter::Brace);
> -    let mut it =3D params.stream().into_iter();
> -    let mut parsed =3D Vec::new();
> -
> -    loop {
> -        let param_name =3D match it.next() {
> -            Some(TokenTree::Ident(ident)) =3D> ident.to_string(),
> -            Some(_) =3D> panic!("Expected Ident or end"),
> -            None =3D> break,
> -        };
> -
> -        assert_eq!(expect_punct(&mut it), ':');
> -        let param_type =3D expect_ident(&mut it);
> -        let group =3D expect_group(&mut it);
> -        assert_eq!(group.delimiter(), Delimiter::Brace);
> -        assert_eq!(expect_punct(&mut it), ',');
> -
> -        let mut param_it =3D group.stream().into_iter();
> -        let param_default =3D expect_param_default(&mut param_it);
> -        let param_description =3D expect_string_field(&mut param_it, "de=
scription");
> -        expect_end(&mut param_it);
> -
> -        parsed.push(Parameter {
> -            name: param_name,
> -            ptype: param_type,
> -            default: param_default,
> -            description: param_description,
> -        })
> -    }
> -
> -    parsed
> -}
> -
> -impl ModuleInfo {
> -    fn parse(it: &mut token_stream::IntoIter) -> Self {
> -        let mut info =3D ModuleInfo::default();
> -
> -        const EXPECTED_KEYS: &[&str] =3D &[
> -            "type",
> -            "name",
> -            "authors",
> -            "description",
> -            "license",
> -            "alias",
> -            "firmware",
> -            "imports_ns",
> -            "params",
> -        ];
> -        const REQUIRED_KEYS: &[&str] =3D &["type", "name", "license"];
> +/// Parse fields that are required to use a specific order.
> +///
> +/// As fields must follow a specific order, we *could* just parse fields=
 one by one by peeking.
> +/// However the error message generated when implementing that way is no=
t very friendly.
> +///
> +/// So instead we parse fields in an arbitrary order, but only enforce t=
he ordering after parsing,
> +/// and if the wrong order is used, the proper order is communicated to =
the user with error message.
> +///
> +/// Usage looks like this:
> +/// ```ignore
> +/// parse_ordered_fields! {
> +///     from input;
> +///
> +///     // This will extract "foo: <field>" into a variable named "foo".
> +///     // The variable will have type `Option<_>`.
> +///     foo =3D> <expression that parses the field>,
> +///
> +///     // If you need the variable name to be different than the key na=
me.
> +///     // This extracts "baz: <field>" into a variable named "bar".
> +///     // You might want this if "baz" is a keyword.
> +///     baz as bar =3D> <expression that parse the field>,
> +///
> +///     // You can mark a key as required, and the variable will no long=
er be `Option`.
> +///     // foobar will be of type `Expr` instead of `Option<Expr>`.
> +///     foobar [required] =3D> input.parse::<Expr>()?,
> +/// }
> +/// ```

It's a shame that this macro bails on the first failure rather than
accumulating them all.

> +macro_rules! parse_ordered_fields {
> +    (@gen
> +        [$input:expr]
> +        [$([$name:ident; $key:ident; $parser:expr])*]
> +        [$([$req_name:ident; $req_key:ident])*]
> +    ) =3D> {
> +        $(let mut $name =3D None;)*
> +
> +        const EXPECTED_KEYS: &[&str] =3D &[$(stringify!($key),)*];
> +        const REQUIRED_KEYS: &[&str] =3D &[$(stringify!($req_key),)*];
> +
> +        let span =3D $input.span();
>          let mut seen_keys =3D Vec::new();
>
>          loop {
> -            let key =3D match it.next() {
> -                Some(TokenTree::Ident(ident)) =3D> ident.to_string(),
> -                Some(_) =3D> panic!("Expected Ident or end"),
> -                None =3D> break,
> -            };
> +            if $input.is_empty() {
> +                break;
> +            }

`while !$input.is_empty()`?

> +
> +            let key =3D $input.call(Ident::parse_any)?;
>
>              if seen_keys.contains(&key) {
> -                panic!("Duplicated key \"{key}\". Keys can only be speci=
fied once.");
> +                Err(Error::new_spanned(
> +                    &key,
> +                    format!(r#"duplicated key "{key}". Keys can only be =
specified once."#),
> +                ))?
>              }
>
> -            assert_eq!(expect_punct(it), ':');
> -
> -            match key.as_str() {
> -                "type" =3D> info.type_ =3D expect_ident(it),
> -                "name" =3D> info.name =3D expect_string_ascii(it),
> -                "authors" =3D> info.authors =3D Some(expect_string_array=
(it)),
> -                "description" =3D> info.description =3D Some(expect_stri=
ng(it)),
> -                "license" =3D> info.license =3D expect_string_ascii(it),
> -                "alias" =3D> info.alias =3D Some(expect_string_array(it)=
),
> -                "firmware" =3D> info.firmware =3D Some(expect_string_arr=
ay(it)),
> -                "imports_ns" =3D> info.imports_ns =3D Some(expect_string=
_array(it)),
> -                "params" =3D> info.params =3D Some(expect_params(it)),
> -                _ =3D> panic!("Unknown key \"{key}\". Valid keys are: {E=
XPECTED_KEYS:?}."),
> +            $input.parse::<Token![:]>()?;
> +
> +            match &*key.to_string() {
> +                $(
> +                    stringify!($key) =3D> $name =3D Some($parser),
> +                )*
> +                _ =3D> {
> +                    Err(Error::new_spanned(
> +                        &key,
> +                        format!(r#"unknown key "{key}". Valid keys are: =
{EXPECTED_KEYS:?}."#),
> +                    ))?
> +                }
>              }
>
> -            assert_eq!(expect_punct(it), ',');
> -
> +            $input.parse::<Token![,]>()?;
>              seen_keys.push(key);
>          }
>
> -        expect_end(it);
> -
>          for key in REQUIRED_KEYS {
>              if !seen_keys.iter().any(|e| e =3D=3D key) {
> -                panic!("Missing required key \"{key}\".");
> +                Err(Error::new(span, format!(r#"missing required key "{k=
ey}""#)))?
>              }
>          }
>
> @@ -319,43 +277,178 @@ fn parse(it: &mut token_stream::IntoIter) -> Self =
{
>          }
>
>          if seen_keys !=3D ordered_keys {
> -            panic!("Keys are not ordered as expected. Order them like: {=
ordered_keys:?}.");
> +            Err(Error::new(
> +                span,
> +                format!(r#"keys are not ordered as expected. Order them =
like: {ordered_keys:?}."#),
> +            ))?
> +        }
> +
> +        $(let $req_name =3D $req_name.expect("required field");)*
> +    };
> +
> +    // Handle required fields.
> +    (@gen
> +        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
> +        $key:ident as $name:ident [required] =3D> $parser:expr,
> +        $($rest:tt)*
> +    ) =3D> {
> +        parse_ordered_fields!(
> +            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)* [$=
name; $key]] $($rest)*
> +        )
> +    };
> +    (@gen
> +        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
> +        $name:ident [required] =3D> $parser:expr,
> +        $($rest:tt)*
> +    ) =3D> {
> +        parse_ordered_fields!(
> +            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)* [=
$name; $name]] $($rest)*
> +        )
> +    };
> +
> +    // Handle optional fields.
> +    (@gen
> +        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
> +        $key:ident as $name:ident =3D> $parser:expr,
> +        $($rest:tt)*
> +    ) =3D> {
> +        parse_ordered_fields!(
> +            @gen [$input] [$($tok)* [$name; $key; $parser]] [$($req)*] $=
($rest)*
> +        )
> +    };
> +    (@gen
> +        [$input:expr] [$($tok:tt)*] [$($req:tt)*]
> +        $name:ident =3D> $parser:expr,
> +        $($rest:tt)*
> +    ) =3D> {
> +        parse_ordered_fields!(
> +            @gen [$input] [$($tok)* [$name; $name; $parser]] [$($req)*] =
$($rest)*
> +        )
> +    };

It would be nice to avoid the combinatorial explosion here, though I'm
not immediately sure how.

> +
> +    (from $input:expr; $($tok:tt)*) =3D> {
> +        parse_ordered_fields!(@gen [$input] [] [] $($tok)*)
> +    }
> +}
> +
> +struct Parameter {
> +    name: Ident,
> +    ptype: Ident,
> +    default: Expr,
> +    description: LitStr,
> +}
> +
> +impl Parse for Parameter {
> +    fn parse(input: ParseStream<'_>) -> Result<Self> {
> +        let name =3D input.parse()?;
> +        input.parse::<Token![:]>()?;
> +        let ptype =3D input.parse()?;
> +
> +        let fields;
> +        braced!(fields in input);
> +
> +        parse_ordered_fields! {
> +            from fields;
> +            default [required] =3D> fields.parse()?,
> +            description [required] =3D> fields.parse()?,
>          }
>
> -        info
> +        Ok(Self {
> +            name,
> +            ptype,
> +            default,
> +            description,
> +        })
>      }
>  }
>
> -pub(crate) fn module(ts: TokenStream) -> TokenStream {
> -    let mut it =3D ts.into_iter();
> +pub(crate) struct ModuleInfo {
> +    type_: Ident,
> +    license: AsciiLitStr,
> +    name: AsciiLitStr,
> +    authors: Option<Punctuated<AsciiLitStr, Token![,]>>,
> +    description: Option<LitStr>,
> +    alias: Option<Punctuated<AsciiLitStr, Token![,]>>,
> +    firmware: Option<Punctuated<AsciiLitStr, Token![,]>>,
> +    imports_ns: Option<Punctuated<AsciiLitStr, Token![,]>>,
> +    params: Option<Punctuated<Parameter, Token![,]>>,
> +}
>
> -    let info =3D ModuleInfo::parse(&mut it);
> +impl Parse for ModuleInfo {
> +    fn parse(input: ParseStream<'_>) -> Result<Self> {
> +        parse_ordered_fields!(
> +            from input;
> +            type as type_ [required] =3D> input.parse()?,
> +            name [required] =3D> input.parse()?,
> +            authors =3D> {
> +                let list;
> +                bracketed!(list in input);
> +                Punctuated::parse_terminated(&list)?
> +            },
> +            description =3D> input.parse()?,
> +            license [required] =3D> input.parse()?,
> +            alias =3D> {
> +                let list;
> +                bracketed!(list in input);
> +                Punctuated::parse_terminated(&list)?
> +            },
> +            firmware =3D> {
> +                let list;
> +                bracketed!(list in input);
> +                Punctuated::parse_terminated(&list)?
> +            },
> +            imports_ns =3D> {
> +                let list;
> +                bracketed!(list in input);
> +                Punctuated::parse_terminated(&list)?
> +            },
> +            params =3D> {
> +                let list;
> +                braced!(list in input);
> +                Punctuated::parse_terminated(&list)?
> +            },
> +        );
> +
> +        Ok(ModuleInfo {
> +            type_,
> +            license,
> +            name,
> +            authors,
> +            description,
> +            alias,
> +            firmware,
> +            imports_ns,
> +            params,
> +        })
> +    }
> +}
>
> +pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>      // Rust does not allow hyphens in identifiers, use underscore instea=
d.
> -    let ident =3D info.name.replace('-', "_");
> +    let ident =3D info.name.value().replace('-', "_");
>      let mut modinfo =3D ModInfoBuilder::new(ident.as_ref());
>      if let Some(authors) =3D &info.authors {
>          for author in authors {
> -            modinfo.emit("author", author);
> +            modinfo.emit("author", &author.value());
>          }
>      }
>      if let Some(description) =3D &info.description {
> -        modinfo.emit("description", description);
> +        modinfo.emit("description", &description.value());
>      }
> -    modinfo.emit("license", &info.license);
> +    modinfo.emit("license", &info.license.value());
>      if let Some(aliases) =3D &info.alias {
>          for alias in aliases {
> -            modinfo.emit("alias", alias);
> +            modinfo.emit("alias", &alias.value());
>          }
>      }
>      if let Some(firmware) =3D &info.firmware {
>          for fw in firmware {
> -            modinfo.emit("firmware", fw);
> +            modinfo.emit("firmware", &fw.value());
>          }
>      }
>      if let Some(imports) =3D &info.imports_ns {
>          for ns in imports {
> -            modinfo.emit("import_ns", ns);
> +            modinfo.emit("import_ns", &ns.value());
>          }
>      }
>
> @@ -366,7 +459,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream =
{
>
>      modinfo.emit_params(&info);
>
> -    format!(
> +    Ok(format!(
>          "
>              /// The module name.
>              ///
> @@ -536,12 +629,12 @@ mod module_parameters {{
>              }}
>          ",
>          type_ =3D info.type_,
> -        name =3D info.name,
> +        name =3D info.name.value(),
>          ident =3D ident,
>          modinfo =3D modinfo.buffer,
>          params =3D modinfo.param_buffer,
>          initcall_section =3D ".initcall6.init"
>      )
>      .parse()
> -    .expect("Error parsing formatted string into token stream.")
> +    .expect("Error parsing formatted string into token stream."))
>  }
> --
> 2.51.2
>
