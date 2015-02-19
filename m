MIME-Version: 1.0
In-Reply-To: <54E5D7F1.2090804@mentor.com>
References: <1424177796-17923-1-git-send-email-harish_kandiga@mentor.com>
	<CAKi4VA+nJknEwkQfUWf0VbcEMzzz3uHwwNe8OuWQOi-K0sWxjQ@mail.gmail.com>
	<874mqjuaky.fsf@rustcorp.com.au>
	<CAKi4VAKpzUcakX+BY8dYE8Jx4BUOqy_-LZWH5gJWtwn3EdbE0g@mail.gmail.com>
	<87vbiysv1v.fsf@rustcorp.com.au>
	<CAKi4VAKc_zrPptt2ZKT_Jj8bLdL1bt0emhtEuodV2WKkas9ZOw@mail.gmail.com>
	<54E5795C.5050804@mentor.com>
	<CAKi4VA+ceEsQm30+4q_hvgtm2Uwo1cJSQdJErUh6hsd=fwbe0g@mail.gmail.com>
	<54E5D7F1.2090804@mentor.com>
Date: Thu, 19 Feb 2015 10:43:19 -0200
Message-ID: <CAKi4VAJ=sx-GvcQ8vj70F=F2x3p-LW8RCQ1eycZhssBu1Tr58g@mail.gmail.com>
Subject: Re: [PATCH] libkmod-module: Remove directory existence check for KMOD_MODULE_BUILTIN
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Harish Jenny Kandiga Nagaraj <harish_kandiga@mentor.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 19, 2015 at 10:32 AM, Harish Jenny Kandiga Nagaraj
<harish_kandiga@mentor.com> wrote:
>
> On Thursday 19 February 2015 04:00 PM, Lucas De Marchi wrote:
>> On Thu, Feb 19, 2015 at 3:49 AM, Harish Jenny Kandiga Nagaraj
>> <harish_kandiga@mentor.com> wrote:
>>>> Harrish, in your patch if you just change the "return
>>>> KMOD_MODULE_BUILTIN;" to "return KMOD_MODULE_COMING;" does it work?
>>> Yes. Returning KMOD_MODULE_COMING instead of KMOD_MODULE_BUILTIN  works=
. The built-in modules are handled by looking at the modules.builtin index =
file. Is there any chance of returning KMOD_MODULE_COMING for builti-in mod=
ules? If it does not have any impact, then the fix should be fine.
>> well... you're not returning KMOD_MODULE_COMING for a builtin module.
>> Having the directory /sys/module/<name> and not the initstate could be
>> either that the module is builtin or that there's a race while loading
>> the module and it's in the coming state. However since we use the
>> index to decide if this module is builtin in the beginning of this
>> function, here it can only be the second case.
>>
>> However... mod->builtin in the beginning of this function is only set
>> if the module is created by a lookup rather than from name or from
>> path.... maybe here we need to actually fallback to the index rather
>> than the cached value, otherwise this test would fail (considering
>> "vt" is builtin):
>>
>> kmod_module_new_from_name(ctx, "vt", &mod);
>> kmod_module_get_initstate(mod, &state);
>>
>
>
>
> something like this ?
>
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index 19bb2ed..d424f3e 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -99,6 +99,8 @@ struct kmod_module {
>          * "module", except knowing it's builtin.
>          */
>         bool builtin : 1;
> +
> +       bool lookup : 1;
>  };
>
>  static inline const char *path_join(const char *path, size_t prefixlen,
> @@ -215,6 +217,11 @@ void kmod_module_set_builtin(struct kmod_module *mod=
, bool builtin)
>         mod->builtin =3D builtin;
>  }
>
> +void kmod_module_set_lookup(struct kmod_module *mod, bool lookup)
> +{
> +       mod->lookup =3D lookup;
> +}
> +
>  void kmod_module_set_required(struct kmod_module *mod, bool required)
>  {
>         mod->required =3D required;
> @@ -1729,7 +1736,7 @@ KMOD_EXPORT int kmod_module_get_initstate(const str=
uct kmod_module *mod)
>                         struct stat st;
>                         path[pathlen - (sizeof("/initstate") - 1)] =3D '\=
0';
>                         if (stat(path, &st) =3D=3D 0 && S_ISDIR(st.st_mod=
e))
> -                               return KMOD_MODULE_COMING;
> +                               return mod->lookup ? KMOD_MODULE_COMING :=
 KMOD_MODULE_BUILTIN;

no. I guess this doesn't pass the proposed test:

1)
kmod_module_new_from_name(ctx, "vt", &mod);
kmod_module_get_initstate(mod, &state);

this must return builtin

2)
kmod_module_new_from_lookup(ctx, "vt", &list);
... (get mod from list)
kmod_module_get_initstate(mod, &state);

this must return builtin as well.

I suggest you add a kmod_module_is_builtin() which does the lookup
(but doesn't increase the module refcount, i.e. doesn't call
new_module_xxxx()) iff it's not already done. For this you will need
to change mod->builtin to an enum: enum { XXXX_UNKNOWN, XXXX_NO,
XXXX_YES } then you do:

bool kmod_module_is_builtin(mod)  (don't export this function)
{
        if (mod->XXXX_UNKNOWN) {
              ... lookup in builtin index
        }
        return mod->builtin =3D=3D XXXX_YES;
}

then you change the users of mod->builtin.

--=20
Lucas De Marchi
