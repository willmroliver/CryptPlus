#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the CryptPlus-1.0-Darwin subdirectory
  --exclude-subdir  exclude the CryptPlus-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "CryptPlus Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
OpenSSL is available under version 2 of the Apache License, given below:

-------------------

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions.

"License" shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document.

"Licensor" shall mean the copyright owner or entity authorized by the copyright owner that is granting the License.

"Legal Entity" shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, "control" means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity.

"You" (or "Your") shall mean an individual or Legal Entity exercising permissions granted by this License.

"Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.

"Object" form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.

"Work" shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below).

"Derivative Works" shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof.

"Contribution" shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, "submitted" means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as "Not a Contribution."

"Contributor" shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.

4. Redistribution. You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:

You must give any other recipients of the Work or Derivative Works a copy of this License; and
You must cause any modified files to carry prominent notices stating that You changed the files; and
You must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form of the Work, excluding those notices that do not pertain to any part of the Derivative Works; and
If the Work includes a "NOTICE" text file as part of its distribution, then any Derivative Works that You distribute must include a readable copy of the attribution notices contained within such NOTICE file, excluding those notices that do not pertain to any part of the Derivative Works, in at least one of the following places: within a NOTICE text file distributed as part of the Derivative Works; within the Source form or documentation, if provided along with the Derivative Works; or, within a display generated by the Derivative Works, if and wherever such third-party notices normally appear. The contents of the NOTICE file are for informational purposes only and do not modify the License. You may add Your own attribution notices within Derivative Works that You distribute, alongside or as an addendum to the NOTICE text from the Work, provided that such additional attribution notices cannot be construed as modifying the License.
You may add Your own copyright statement to Your modifications and may provide additional or different license terms and conditions for use, reproduction, or distribution of Your modifications, or for any such Derivative Works as a whole, provided Your use, reproduction, and distribution of the Work otherwise complies with the conditions stated in this License.

5. Submission of Contributions. Unless You explicitly state otherwise, any Contribution intentionally submitted for inclusion in the Work by You to the Licensor shall be under the terms and conditions of this License, without any additional terms or conditions. Notwithstanding the above, nothing herein shall supersede or modify the terms of any separate license agreement you may have executed with Licensor regarding such Contributions.

6. Trademarks. This License does not grant permission to use the trade names, trademarks, service marks, or product names of the Licensor, except as required for reasonable and customary use in describing the origin of the Work and reproducing the content of the NOTICE file.

7. Disclaimer of Warranty. Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.

8. Limitation of Liability. In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall any Contributor be liable to You for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this License or out of the use or inability to use the Work (including but not limited to damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses), even if such Contributor has been advised of the possibility of such damages.

9. Accepting Warranty or Additional Liability. While redistributing the Work or Derivative Works thereof, You may choose to offer, and charge a fee for, acceptance of support, warranty, indemnity, or other liability obligations and/or rights consistent with this License. However, in accepting such obligations, You may act only on Your own behalf and on Your sole responsibility, not on behalf of any other Contributor, and only if You agree to indemnify, defend, and hold each Contributor harmless for any liability incurred by, or claims asserted against, such Contributor by reason of your accepting any such warranty or additional liability.

END OF TERMS AND CONDITIONS

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the CryptPlus will be installed in:"
    echo "  \"${toplevel}/CryptPlus-1.0-Darwin\""
    echo "Do you want to include the subdirectory CryptPlus-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/CryptPlus-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +205 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the CryptPlus-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� }��e �}`\E���<��ERh�P�PJZ�t7�>x$M�M�kIR(�n7��te���#m�b���j�蟫U��\|y��u��P1xN�E��X���f���ٴ)��L;g�3��7��|�͜9g[C�E�qvn����Rda�e<$'z**+���nOu����{����x3�.�H����P8
�+�� ~:��|A��=��?�A� ��-�
sT��?l�;��ږZݺ�͜Z7%�Q�q.yk���4�-�!��n�_q(�Km���4�e�Z�8m�d�ȗ�^�k�2:䫁�Yݸv���1-{���T���i���e�����M���$WDN�r�����i����<�%��w.v	[�	������cW�Ҭ�P߃�.�;񳩜EӚꚓe_��-�g�e7���D�N���	�o&S�{���_U`�DZ�k�\�J����@xQ4�/E�pM9J}�--W��t�Z:_���\p:����K=�a�F���u��|c�歉��Y�\� s����*6�0��q�s���8�9�q�s���8�9�q�s���8�9�q��n}C�+
�?Z��G
��6��vX��ȑ#J�z�����ٻ���u�/\
�m��H75"?M�\i�Y7���h5��6�7�g	�ҏ��V�����!���7���1?��O��%�����K���:�xe��~샒z!j��"��X럮ܵn��@o@'��m{z��~��=�B�w�4l,�Ƚ��Q=�<�=7�<'�@�{��\N��~�joC��A�l���p�Uxgw�6`���Y�"VDQ��Gt>+⡞���5r����DCK�eL:���Fh��m{�.��6Y>	nfh_h�
�Y���6&��u�b(���>y*��v��+X��P�g.�N0<	!���1�ɂPqd��pv�C�z/�z�����3��|�*�5����12�n:�!y�$V�.�LoJ����Jl?��y����?�.-݁��V`�x@~}-��f��xi���i��%�]�������O��Y/S����>���>v��c{� ���+ysP�����|������A��{M�m�eL
����L圵���+�:�p��E]g��t�Z���Xg�C���nX����Եw�,��=&�:���z+,�ʺC��&Qu3Q�����Τ�
�o5*b�,�8����s ;{e��X�$��O�j�~(�[�[e��=��=�r0���Px��W���p����i��4WC�#I7 ��2ѯ�^�����G�b]�^��E�[�����#�ё?j�/f����ɿf��`Ept���W{����c��o[��rK���ۮ�#O1���OcoB���
e�����~�^M�M}���u�~���=kk/����`D���i��De^*p���4%�O1�5�g��jH�K��@+��e�xM��|��l^����]��jm�1%�F�����C�߇�Z	�
�~��0�fN�����E~ȷu�Bd�T=�߹"�3֩z��0���^|��09���Cн�[�$M���q�[�A��b��4����)T"ݯ�3pp��9���\��B���E4�����S����(b��!o)�]tc7{�ڣ���|Š���;��$�M�꠼A�����xh���+���wL��+�i*W&����P9�cl�'�{bC��A��y%_�>8"�U��>,��? ����BN���T����|���E���8=&?�b�=̬�Iy��.J�Zo����/�	�c��;pJJ,�1]�<�ܨ<T �����]Z�^�{\X���F+K~)����_��tH����]޻p�S_��y��m[�a
J�W&�i�u��4e=��+�Ds�
��4��}��LC�u��!yp����}9ђ����I1YU�/�DÌO���Eɪ�!yw-��O���k�V��y�Q��լ��Z}���ZT���~���Ѕ�	��!���;���t��m#`�NS���X��It�&z���n�½�
4F�#�eށf��#�����݁���B�{������?
�ϯ�;w�HE}���A;w�4Yi�C!�0�ۊd���3��"9M۩�^�.��������0�N��ߴ���j��E��2�?��E�V�D�@~��/Ҍ�3���x�|�;�Vc჏���
�v�_�Z��JY���T�i�Г�3V�7�g��򴵳���ec?Y���p��FeZ�N�sHɱ��G%��?��y\�^�׹���2�Gz��0w��& �
��eჩ�����.˷-E�i?�35�)m��r��[�;���6�V�N�����1�G-���Z����tķ8��l��fq
����%���K�ƃ�?o~s���w�ĉ����?���] ����S�{N���>
����Afm������`Ò�7����{D8�@�`{�XW�f�Nq��o����/��k����=��vj��37㧗����G�%��l3f잇����x�����wF�oO}�Ͱ����k��+����_�p�"8Ȟ"<D�T��^&�^�n�+ش�`Y�cf�ogk��ոLxr��'�jl��򥼀=,K=7��R
X�ie�b���O��8����������5/��K��l|��!Y���.��Y��U?���{����2W��홭�"���<_gJ?�z~����t{
���P0��ˠw_+������m����ڨ����Q�	}gVZ0�
7ݖ������m����'D]��v�)�,�f��l�a���3���]s�!d��V����ayd��|8�μ=/�*�(/K{l�?��fI����������^^=�
�ޝ:(����~��{�]J�2�q3����_�H�����|������rJ�����.X��x�,�x��c�]����@t�t+�]��Gr��KM��R��1�c9
� *�U�,�F@~���a��1��r���;m�b{���_y4s3�|��\E�:�B9�2]�)��"���f��k����d�=ğBc�C�K�<�^_f��v_�[�j�=9h*������'S�5>�CB�
����8.�]ݿ����\�/�
~��@��^~��1ag�yu�)�ۙb��=���C��G��э��]L���N�ɠK#�����r=��r��w���\�����uU>��p�~�-6���׆ނ��p�Ɇ��lx�wД/�&�F�|?K
�z���폹�&}����m��,3��E��ٚ������Z���$;щBz�i��5>?��Ǉd�<eУ�V������?e/��{)W =�.J�W
����߲���ð8�o+�hZ9��x_��-%�օ�Ο��A!S�h�s�BꬽӮB��?T�i�n��X�,l�><b�?`�~�,T'ZT�l��4e=��������J��Oт�7.$YB�ܳ@�]��o^��w ���z&��(�Z;�L�����^n�V�.A�Q�~|�>**��N���3�ρ��<���0?(� ���_(��nq��j|��gp��&ffY����zl��ǘZaeT��Ňn�c���%�*����t|r�!;�2�V�[�k}|��+���F���3�L�Di�<�/w���T�?��4�~�k>c����z��2���Z�0W�C������[�r[���̱�����a��/]3��x$�|f^����w�d��<�,��6���^��Q�x���cG�z�vH�t��Gy^��ye|��S����a����O�$e	�5����[��dH�Y�_Y"(O��s� 4�Ȣu������/����������������v������e��a���YU�˷���$����������*����+2R�\��5l�gt������һ�L��d^�h��z�{��$.7�~������D�kʃ=62F�s���ä�ayà�?��In�gz
��L�Ҝ���3,-�����s�������2|@ax�T_�Ů�&{ٶ�%�"x6|����vg���h�	wW�8������ r�+����X=�p���bF�׫�X�����a�:t![��ƑD90����ecT���(ք�=<f�Bw��G����'�Oرy�]fx����Nm� �t����y-�g�������H�&.l�w��骲4�g����$��	n�������2֙��]�J�����-�ޛ\��ޑ��t܆YA�pn�@��c�HT��4�-���0n�z�n���~
�}n��Ffz�7�� {�&��{����>,�߅ta �>V�Yp��a(�'��aF9,*Ϡ�����D�,~��nxU=P��YٝO��WO�e�?���c������G���+��������ͥ�=;����w����?����G0ϧ�����������������q.�&���?=��w/?��w��R�]�lf}w����~��ws����'�K�w�3����g��5璾���[�ϰ�w��<F}���E�}�:
:}�����v&}��Ӳ�w=l�:"���9lA�kR�ˮ�
���JUy��W����#�)�����o��}��ی 𰿆}b�Y�{󇥺�n��� ��E��^Йi�`�}��=�Ϧ�Q��,�2�_�g^��߿�3,[����ʎ�YU�~��zSڤ�������Y��;T�u��O`�۩H������JoѦ�$j7�m@^[�R��0`�[�}�Q����i�y&g�_�5Y���n?E}G�ޔ�K��|����R���հ{�*�G�=����5ﻰ��k�9�gMV������ώ��^����zS����0����-)�����>��m���3��۫L�+OD���yK9�;��
o����-��S
$��<}����{Tv�&��4`��|��0��;��$����i���|�L���>�O����TI���f��wY�e�|��
��Hx!$ٿc���
����|�����Ĉ�)/ֽy/+����fU�'�GZ��K铋&Y|�〼� v��}{k��H��������A}�9̶
��N�j�7N��l؍;	�E������N�W֟�N�?$O/H[l
�5�V�]��5��wZ�F}�S0���e>CZ��������0��?���7Ϳ�|��_�m��?��%���<���4s����}yZ�vf~��-�\�̳�G����H��y�2��H�5#�&�e���!�kv�9om�����]��{׼��`3�)��}����1�{��m�C�\�Op__���Le6�4׿.��y���|�r/d��F�t[���O|�V�Tַơ%:�� �}
�쟔 ��.]�N��A_�ȥ�Ё{4oxd:��<v}�&�j�Ӿ?e�>���X�?��������{��9��k�����7r�34t�Ye���G����\#��qɅGn�g����Cy�o�(��
��;=�ȹ��캏]�����$�����3��Kv}�]�����"��Į���;v�=��ʮ2����ήo����ɮf׷��0���]�a���U(�k���v-`���:�]O`�"v=�]��\v-a��캀]K��ͮe�Z��U캘]����z�ְ�rv�g�����W��U��1v�Ȯײ�'��zv�f���&v��]w��������Uv�gׯ�����
���֥��#�
� h����������~~���߂�_�����«n���6q��ն�st��C��S��v�����ȿ�%\v�.a��߸�]�kٽS�����\B`�s.��t�%|εM�u���Z����?�K�p�k����/�́�ι���M�S����E���~#_x,�
����>7A蛈i��8��a� 	k��_O~8i�e)����:c�P+��V��ũ�AX��^�h5a� x��%
n��|IX;^}�ë�ЋW�_#|, ?u�C_{��[N�9·s.�tf9��6��re���H���|��F_����.%����KE�Q֥� �o
D:��`,&x	,ۤ8��'���
��F�J�Tk8\�,���C	\i�.��"�C�DH�v7~C��}#�=�6<�*��eޖ�8܉"�]��
u�,��\EԸ���
!L
��ah��3��p��P.�A�\�U3��\�B�w!��6�)��@c1ăM�^
yA��_ �a�@^�P��^�[������� 
�R8��(,������H�IΠp&�'Sx
��(<���(�M���A��E�H��Sx�s(<�¹�Ga	��(�O��.�p!��.��M���2
�)�����*
�)\L�
�R���(��(���
k)\Na��z)\A�J
(l��
WQ���5��p�>
/����f
[(\O�e^N�
�`��-8�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s܇��������8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q����~�!� \	�Ks/��Y�ݚx�B�ݗ\��A}�+|	���7�����C:�����\���F�{��~V��	�����w�'�
������z�����~ �����׊|!wW����G&������	��@�i�y���Κi�����»w�c����)BN�T!�%�iB���o:A�y��B!g��"�ݻ��4]șs���|����q����$���?���-�!��׃��>�o��:S�]��� �_����0�g����g
����
_�:0,����$��t�3G�ix-AoS�_�ǣq"E:xL��� /���}
��"m6wR��]�T�}q����G6�"m�&)�B��\[�ǒ�^섞�hL�$a��h*�]ۜ,��=���@"$2�����n����B�Dc����%����8�x���Ǖ�*"R�%��
I������:턆����~-�*������=��ަ��nY�MW��P4ᇲ�*%�����6'=�p�8`C����[T���o�{�Y�ܭ�6 le}�'�-�������t
��� LTX�̱�����n��XɌ2���^srIR�w����X�F�Vb�U,�{�U0+X�Y	P�s���
本�:�lK#���=Jn�w�16��5�t5�_��>�#����V���/SC�����wJ����愰3����!�� I�(���l
#�B^/�\VDO>�A~�pk>����a�t��I���(��pG>�p$����5�����0�����ZE�oq
��Q�O���䣠����ׁz��$��s�|��p(q��&�ͼ�Pl�W� 
�^��b,�F�[@|�L�ܓQGf[�GO�?�=L�
��P��`mmԠC���I�2Ok2��s�p�L�y�ϱ�w�r�³3<­3A���?�Yų��~
�����~��L]�z�m��L�����Y���#�!�(���W��45<r2������ɪ��M�M�;p��"���@j�c��1`���˄wO��ze&kO�a��b���L���sJn�`
��v�N9�����Z_���.C������J/���
M���p˩�ew�S�Y�/G�I�>c��}5���i��nэ�H�q�#.�;w���q�kD�F_
��9�y�%����[��l�e�D�� �'�Ȩ���٣�wNl9�}�d�⇅G�_����ʲ���[�-n��6f�A�����߫�p�k�^v�yV8��[Ei����^D&�`�,��vZVԷM��
�V0ٌ�nf�Wk�*����R�#�@�TB�&%E��1�կ�����0��]�6,�N�0�FSI�}TF1v	�ښj�E=�W�!n�8�͋�?V+m�x!Z[�%�b5��H����zAFh�#a���p2�֦���P8l�A�P�*4C�6�f���`w���T���̕�jKn�i����<�Y�	���Y��2ˡ���,ơev�8Ns��n��`?�I�T��o���os-��u-�u-n��´��[+$NH`�Ԏ�;p]`½�/;��3C��˒!}I�C(�3�tT�y��>�@MC]!X������==Þ���cߟŬ?���q��?������5��Gk$���Hu⭌�A�6�:�dJ5z0OI��V[}u�U���Ih9�j� �L�U0�0S!�zؚ���|�X���.��L�=ݓ�qYWj��S��y+�Y��`���O#U����
�H��/O���0���1<��OhB��Q�Qb
H�E\�H�y�ݷ0�_֑Y�Z���Zb��qӬ�Y�K�0c[�k�&ʗ L0�A�Ag0�8.ً�I�T96�A6��(�����8��Oj����P[�ɩʅ�U���o���m1���݉�]�p&W������)+���ɺζ��e_�� a��Ɖ���6��۪�6EW�2v�j誵�u�Z���Ӷ��|e��n���d��Q�:��>PG8֣��u��\iΣt�ѹ����0��
�,��`g��Z��6�ҫ�Ÿ�K�26F���r2��H`K��K�	������`��R�ǿ*�j�ˎy�ϰs:��c� ޛ�TӪ��-�츋�~�y|ٷ�ʺ::[�]0ūL1nSL�)��Sm�Yb��T���ͩ*��Q�fƫ�|V��Zl.q��̪�̅�mf�Sf��S��Wef�,h3�3kefᗙ3���Yif��L�ʜ�ڜj����f�[�m!�r35�E��S�ɂ�l��E3Z0Ui1,�̢�,�E˚�Sf���|���fV���@6�Um�bs�K,�m��rdY��Sa!Y��jQ�E���o�n��`�-�͵�XR4��ŐYb!k�jQ#�E�{�z,��n(�ڤE�qt01UWV�,�⡻����DOEeEU�����ݞ
w�G+�'S�K%��8����h8�u:H�ޞ��#~H���}n�tS,6�e�aRQa����*��e�U�*h����rAt�7#V�_���	�Gڤv�qm����^�wC]C�ڕ^��s >��nM>���x�V/�Ĥ�!|IME�KZm���3,ݤ�Y�/%/�9`�+6�3ű�C,�\mR�x�=�����U�D,�D�|�x��ɋ�ϟ,�kZ�!��/�
�I	q��ܼZ������
���b����}EE�P����X2�����E� ��@"��ɜ&&�VuťEP��+-Ĉ�Y�P���Pr�4��j�D����&�� 1=`�
,�ĝ����b�b�$�H��^�{���-k����V+�G�;�uj���D�NĤ`R�{e���=�+�l����!)&�iy�IH�f��|d�!��e�H�-]�G&'�Z:���\����Ia))eLj��z�R�P��]8�r-s�g����+	ho7��������bW������ذ�;G����mt] �ʩB'�M�;I���]q.�P_��5K�#bk4��S���_�I�%1��*ľ�����@2)uƒ������}ЩD�ў���>6W��pU��
+̩�W�K�V�JX��5L�����Q,�M$�Y�V��֗IU�,e�ˠ��Q
�I��+uI�~G�V'
,>�4���bS�RKr4�Z}�)��k����~��L���5��{Lmh�)���M��)��<� #$�SU����eT���%��ch�jɼ1���0�I.�b�OK[B�$��B�t<e�O1�Mv�Oo�ԗ) m��]S^�^�J�n��]oIH�.��iJeNf-~��z�6�[j���}j���)Ү�����!?�u�P�����p�Yƨ��n��ÿݞ�2�c��/����[��Ż���To�=h��;�m�5�H�Cb�^7�]�T\�V9x[�w�ݛž$գl�Z�r��%��T�*g����Ս�9[x��h�����5))�u��D��=��5�3�MgJx�6�
��Ϝ�ͥ��ᐄ�wyhqd0Š�D�;��l�����-zױJ����?wkZ>�PZX)g���fK�K�; ә���q�Я��h*i����eFiz��ħ.Mե"��_�j,��H��pu�k���"		���Ha[��@��$e��Xc�9����,J��Ҹ	A��$�+���?P'�N�\�o]�3�SDB�ف�(�A���,z�a�� *�#��jo6ta�fՌ��k�f�SGR���h��ؑ'�����6���m3�̊zB�Y�2�c��T�c�s��L�f�
���	�'��D����J����Ҷ!��'��̵�"i��&6��I��nZ��m��)������T.��)��5}�]({z �ۆq���6L��%���.1XݔVǶBg���!�|������(�b�-�s}6�-^l���b1&_ʪ���O& �-�1���Dl�H'�KE�C2 q�R�	FSqh�6:��S'|L�p;%�����p��[b��˳P�E�@9�%����"�$)=Qi�y��`�2C/�� 3P�G��Z�6Βҟm�J]41�B�[L][=i��Y�ڪ#��}׮;S� �캃c�������G5Ư�Q���K��wW��_]�v���Ù���_���_��[�2%8�7@/��м�� 4$:��e͓�&H ?+��V ��rm�e�i ���K�6k�Ɣ�ڿ�fq�$,E�^#��?֮��_�2�\�Mad��J��D�_u��-�������!���Fۈ�ܿ��H-S?�0�G
�c�~��l������?�y|� M���O���yP�Wz���8���o������p*���qKQ9��L�hI���fon)����J�o��Ց-1�S����=����F-�|�/���3͵>�i!.�����K�������T�U��WV�;���/Τ����Y�}�7������1��`�Sk�ԇ��ـ=�>����&�r�;��Or.������#&�Qm�#�l�Jפa������)�
&ޑ���'�P��F I�9Z�nK+Pරx��Fii)c�"UX���;�"�y���9w�}<�Q�7�`ŵ9o���/ad�޶t��4��,~�;����"��u[^P�Pďl���sAڈP�vz�Xu,]9�NY�a�á����gt�1���SU�|���p��A��������eN��/Nm��}�Tb�{��ۿ�}��i����?�WL�R2Q�}�������l�*����*˜�?�;'��;�Ƚn
�c?gY�[��`�R�e�h-/-��7�����&k�̹L��%�:c�xRl���q(
��vv�5���VX��G�WG���G3Izy��OHIy�ߺ����ժ�=�",Β�t:��e�3N�ba|Pk>��@ܼ)�$nfk<�RD��R�m+�Y�
�=z�������h\��ysP:?_���i�ۑh�.��%<KmJZvj/��l��ZWll�i�
���Jj}>��zі���omc��^Km�Jo�h	-K3	#3
���
[��]� �Fc"�D;�X�'s9��h�jߚ���V1L� �V��d�TTG'N��$��N���za[ef��!�ߠ�ӆfJ�N#�J5ߨ����|�q�vU��^	���L�fa�N�U�Ү*��3XZ��mQ�O.Lv���S�@1��������糳�,��@�>�Ҷ �ƃ?��g�����[��[� �/�F��IS��	Jm�z\[��1��
�W��Sм�ā~n	��C��;���7�8s)B��<H 4��e���52-�Lͤ� ��:>fJ��;���S�L]�uW���bnf�.5j>�>�
_�l
tI@�U�"d��L���'����;�P }�_c��f���(�M!���Ң<B�L+��jƥ-�Y��3���1Ev��?������?��*q�������y?��ܶd,s/ͼb�}�q��.��߅�h�X4�h�?***���g��/�_|o���H�{~1[���.��d�AZnU���� ��њ���:K�h\����Jn׮��Ƹ�Tȭ^W�(�BVk��Pd�4�Ҷ� ��t�׭�]��P����M6�@^��VF�F$�FͣZ�j��#�{L�z�O���w����Q�y���`��W�����/�VG!<��H��ʨ�&�c"�',�ķa����6?�9K敢"e/ԧ�1"{����)��D�
��m�챏@]��Hј�y�&�[��".�ClM��'k���֭�f_��kW<����e�R�m%��陮���e�V	W���pv�� �R��Yb�K,����ٶ�����qm}��&�]p\�C�h'B�X)�>LdW��=$K2P�Κ�`�a-kq�5��
$T�V^����5�\�/~ѝhDQؠ�H��RLH�xpTv��ժ�*���CI�PK�|M*+��!ŋ������!�
�s�!j�X2�:�m��<;
��k��7�Ԫ�G�=�;�q�s�Q���x��  